<?php

use \Phalcon\Mvc\Dispatcher;
use \Phalcon\Loader;
use \Phalcon\Di\FactoryDefault;
use \Phalcon\Mvc\View;
use \Phalcon\Url;
use \Phalcon\Mvc\Application;
use \Phalcon\Db\Adapter\Pdo\Postgresql;
use \Phalcon\Session\Manager;
use \Phalcon\Session\Adapter\Stream;
use \Phalcon\Session\Bag;
use \Phalcon\Escaper;
use \Phalcon\Flash\Session as FlashSession;
use \Phalcon\Exception;
use Phalcon\Mvc\Router;

use \Phalcon\Mvc\Model\MetaData\Memory;

use \Phalcon\Mvc\Micro;
use \Phalcon\Http\Response;

// phpinfo();

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');

try {
  // Autoloader
  $loader = new Loader();
  $loader->registerDirs(
    [
      APP_PATH . '/controllers/',
      APP_PATH . '/models/',
      APP_PATH . '/config/'
    ]
  );
  $loader->registerNamespaces(
    [
        'empresa\Models' => APP_PATH . '/models/',
    ]
  );
  $loader->register();

  // Inyección de dependencias
  $contenedorFront = new FactoryDefault();

  $contenedorFront->set(
    'router',
    function() {
      $router = new Router();
      $router->mount(new GlobalRoutes());
      // require APP_PATH.'\config\routes.php';
      return $router;
  });

  $contenedorFront->set(
    'view', 
    function() {
      $view = new View();
      $view->setViewsDir(APP_PATH . '/views/');
      
      // Registrar el motor de plantillas VOLT
      $view->registerEngines([
          ".volt" => 'Phalcon\Mvc\View\Engine\Volt'
      ]);
      return $view;
    }
  );

  // Manejo de Sesión
  $contenedorFront->set(
    'sessionBag',
    function () {
        $session_bag = new Bag("sessionBag");
        return $session_bag;
    }
  );

  $contenedorFront->setShared('session', function() {
    $session = new Manager();
    $files = new Stream([
      'savePath' => '/tmp',
    ]);
    $session->setAdapter($files);
    $session->setId('sessid');
    $session->setName('empresa');
    $session->start();
    return $session;
  });

  $contenedorFront->set('flash', function() {
    $escaper = new Escaper();
    $flash = new FlashSession($escaper);
    $cssClasses = [
      'error'   => 'alert alert-danger',
      'success' => 'alert alert-success',
      'notice'  => 'alert alert-info',
      'warning' => 'alert alert-warning',
    ];
    $flash->setCssClasses($cssClasses);
    return $flash;
  });

  // Cache de metadatos
  $contenedorFront['modelsMetadata'] = function() {
    $metaData = new Memory([
      'lifetime' => 300,
      'prefix' => 'metaData'
    ]);
    return $metaData;
  };

  $parametrosBD = [
    'host' => '192.168.1.60',
    'username' => 'empresauser',
    'password' => 'empresauser',
    'dbname' => 'empresa',
    'schema' => 'public'
  ];

  $contenedorFront->set(
    'db',
    function () use ($parametrosBD) {
        $connection = new Postgresql($parametrosBD);
        // $connection->execute('set search_path=public;');
        return $connection;
    }
  );
  
  $contenedorFront->set(
    'url',
    function () {
        $url = new Url();
        $url->setBaseUri('/');
        return $url;
    }
  );

  // Despachador personalizado
  $contenedorFront->set('dispatcher', function() use ($contenedorFront) {
    $eventsManager = $contenedorFront->getShared('eventsManager');

    // Clase ACL para el manejo de autorizaciones
    $autorizador = new Autorizador();

    // Oir eventos del objeto $autorizacion
    $eventsManager->attach('dispatch', $autorizador);

    $dispatcher = new Dispatcher();
    $dispatcher->setEventsManager($eventsManager);
    return $dispatcher;
  });

  // Despliegue de la app
  $front = new Application($contenedorFront);
  // $response = $front->handle(str_replace("/empresapp/", "", $_SERVER["REQUEST_URI"]));
  if (!(strpos($_SERVER["REQUEST_URI"], "/api/") !== false)) {
    $response = $front->handle($_SERVER["REQUEST_URI"]);
    $response->send();
  }
  else {
    $contenedorMicro = new FactoryDefault();
    $contenedorMicro->set(
      'db',
      function ($parametrosBD) {
          return new Postgresql($parametrosBD);
      }
    );
    
    $micro = new Micro($contenedorMicro);
    //echo $_SERVER["REQUEST_URI"];
    $micro->handle($_SERVER["REQUEST_URI"]);
    
    $micro->get(
      '/api/personas',
      function () use ($micro) {
        echo "En get/api/personas";
        $phql = 'SELECT id, nombre, id_tipo_documento, numero_documento, id_municipio, usuario, clave, creacion, modificacion, rol '
              . 'FROM app\models\Persona '
              . 'ORDER BY nombre'
        ;
    
        $personas = $micro->modelsManager->executeQuery($phql);
    
        $data = [];
    
        foreach ($personas as $persona) {
            $data[] = [
              'id'   => $persona->id,
              'nombre' => $persona->nombre,
              'id_tipo_documento' => $persona->id_tipo_documento,
              'numero_documento' => $persona->numero_documento,
              'id_municipio' => $persona->id_municipio,
              'usuario' => $persona->usuario,
              'clave' => $persona->clave,
              'creacion' => $persona->creacion,
              'modificacion' => $persona->modificacion,
              'rol' => $persona->rol,
            ];
        }
    
        echo json_encode($data);
      }
    );
    
    $micro->get(
      '/api/personas/search/{nombre}',
      function ($nombre) use ($micro) {
        $phql = 'SELECT * '
        . 'FROM app\models\Persona WHERE eliminado<>1 and nombre LIKE :nombre: '
        . 'ORDER BY nombre'
        ;
    
        $personas = $micro->modelsManager->executeQuery($phql,['nombre' => '%' . $nombre . '%']);
    
        $data = [];
    
        foreach ($personas as $persona) {
          $data[] = [
            'id'   => $persona->id,
            'nombre' => $persona->nombre,
            'id_tipo_documento' => $persona->id_tipo_documento,
            'numero_documento' => $persona->numero_documento,
            'id_municipio' => $persona->id_municipio,
            'usuario' => $persona->usuario,
            'clave' => $persona->clave,
            'creacion' => $persona->creacion,
            'modificacion' => $persona->modificacion,
            'rol' => $persona->rol,
          ];
        }
    
        echo json_encode($data);
      }
    );
    
    $micro->get(
      '/api/personas/{id:[0-9]+}',
      function ($id) use ($micro) {
        $phql = 'SELECT * '
              . 'FROM app\models\Persona '
              . 'WHERE id = :id: and eliminado<>1'
        ;
    
        $persona = $micro->modelsManager->executeQuery($phql,['id' => $id])->getFirst();
    
        $response = new Response();
    
        if ($persona === false) {
          $response->setJsonContent(['status' => 'NOT-FOUND']);
        } else {
            $response->setJsonContent(
                [
                  'status' => 'FOUND',
                  'data'   => [
                    'id'   => $persona->id,
                    'nombre' => $persona->nombre,
                    'id_tipo_documento' => $persona->id_tipo_documento,
                    'numero_documento' => $persona->numero_documento,
                    'id_municipio' => $persona->id_municipio,
                    'usuario' => $persona->usuario,
                    'clave' => $persona->clave,
                    'creacion' => $persona->creacion,
                    'modificacion' => $persona->modificacion,
                    'rol' => $persona->rol,
                  ]
                ]
            );
        }
    
        return $response;
      }
    );
    
    $micro->post(
      '/api/personas',
      function () use ($micro) {
        $persona = $micro->request->getJsonRawBody();
        $phql  = 'INSERT INTO app\models\Persona '
        . '(nombre, id_tipo_documento, numero_documento, id_municipio, usuario, clave, rol) '
        . 'VALUES '
        . '(:nombre:, :id_tipo_documento:, :numero_documento:, :id_municipio:, :login:, :clave:, :rol:)'
        ;
    
        $status = $micro
            ->modelsManager
            ->executeQuery(
              $phql,
              [
                'nombre' => $persona->nombre,
                'id_tipo_documento' => $persona->id_tipo_documento,
                'numero_documento' => $persona->numero_documento,
                'id_municipio' => $persona->id_municipio,
                'usuario' => $persona->usuario,
                'clave' => $persona->clave,
                'rol' => $persona->rol,
              ]
            )
        ;
    
        $response = new Response();
    
        if ($status->success() === true) {
            $response->setStatusCode(201, 'Creación exitosa');
    
            $persona->id = $status->getModel()->id;
    
            $response->setJsonContent(
                [
                    'status' => 'OK',
                    'data'   => $persona,
                ]
            );
        } else {
            $response->setStatusCode(409, 'Conflicto');
    
            $errors = [];
            foreach ($status->getMessages() as $message) {
                $errors[] = $message->getMessage();
            }
    
            $response->setJsonContent(
                [
                    'status'   => 'ERROR',
                    'messages' => $errors,
                ]
            );
        }
    
        return $response;
      }
    );
    
    $micro->put(
      '/api/personas/{id:[0-9]+}',
      function ($id) use ($micro) {
        $persona = $micro->request->getJsonRawBody();
        $phql  = 'UPDATE app\models\Persona '
               . 'SET nombre = :nombre:'
               . ', id_tipo_documento = :id_tipo_documento:'
               . ', numero_documento = :numero_documento: '
               . ', id_municipio = :id_municipio: '
               . ', usuario = :usuario: '
               . ', clave = :clave: '
               . ', rol = :rol: '
               . 'WHERE id = :id:';
    
        $status = $micro
            ->modelsManager
            ->executeQuery(
                $phql,
                [
                  'id'   => $id,
                  'nombre' => $persona->nombre,
                  'id_tipo_documento' => $persona->id_tipo_documento,
                  'numero_documento' => $persona->numero_documento,
                  'id_municipio' => $persona->id_municipio,
                  'usuario' => $persona->usuario,
                  'clave' => $persona->clave,
                  'rol' => $persona->rol,
                ]
            )
        ;
    
        $response = new Response();
    
        if ($status->success() === true) {
            $response->setJsonContent(
                [
                    'status' => 'OK'
                ]
            );
        } else {
            $response->setStatusCode(409, 'Conflict');
    
            $errors = [];
            foreach ($status->getMessages() as $message) {
                $errors[] = $message->getMessage();
            }
    
            $response->setJsonContent(
                [
                    'status'   => 'ERROR',
                    'messages' => $errors,
                ]
            );
        }
    
        return $response;
      }
    );
    
    $micro->delete(
      '/api/personas/{id:[0-9]+}',
      function ($id) use ($micro) {
        $phql = 'DELETE '
              . 'FROM app\models\Persona '
              . 'WHERE id = :id:';
    
        $status = $micro
            ->modelsManager
            ->executeQuery(
                $phql,
                [
                    'id' => $id,
                ]
            )
        ;
    
        $response = new Response();
    
        if ($status->success() === true) {
            $response->setJsonContent(
                [
                    'status' => 'OK'
                ]
            );
        } else {
            $response->setStatusCode(409, 'Conflict');
    
            $errors = [];
            foreach ($status->getMessages() as $message) {
                $errors[] = $message->getMessage();
            }
    
            $response->setJsonContent(
                [
                    'status'   => 'ERROR',
                    'messages' => $errors,
                ]
            );
        }
    
        return $response;
      }    
    );
  }

} catch (Exception $e) {
  echo $e->getMessage();
}