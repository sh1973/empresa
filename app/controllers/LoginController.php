<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo de la autenticación.
*/


use Phalcon\Tag;

class LoginController extends BaseController {

  public function indexAction() {

    Tag::setTitle('Ingreso');

    $this->assets->collection('css-login')->addCss('css/login.css');

  }

  // /login/procesar/<login>/<clave>
  public function procesarAction($login = false, $clave = '') {
    echo "Procesando..." . $login . "/" . $clave;

    /*
    $this->dispatcher->forward([
      'controller' => 'login',
      'action' => 'autenticar'
    ]);
    */
    
  }

  public function autenticarAction() {
    
    if ($this->security->checkToken() == false) {
      $this->flash->error("No se permite autenticación automatizada.");
      $this->response->redirect("login/index");
      return;
    }

    // echo "Autenticando...";
    $this->view->disable();

    $usuario = $this->request->getPost('usuario');
    $clave = $this->request->getPost('clave');

    $persona = Persona::findFirstByUsuario($usuario);

    if ($persona) {
      if ($this->security->checkHash($clave, $persona->clave)) {
        echo 1;
        // $this->flash->success("¡Hola " . $persona->nombre . "!");
        $this->session->set('id', $persona->id);
        $this->session->set('nombre', $persona->nombre);
        $this->session->set('rol', $persona->rol);
        $this->response->redirect("dashboard");

        return;
      }
    }

    echo 0;
    $this->flash->notice("¡Credenciales incorrectas!");
    $this->response->redirect("login");

  }
}