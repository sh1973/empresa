<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: administrar listas de acceso.
*/

use \Phalcon\Mvc\Dispatcher;
use \Phalcon\Di\Injectable;
use \Phalcon\Events\Event;
use \Phalcon\Acl\Enum;
use \Phalcon\Acl\Role;
use \Phalcon\Acl\Adapter\Memory;
use \Phalcon\Acl\Component;

class Autorizador extends Injectable {

  const ROL_PUBLICO = 'publico';
  const ROL_PRIVADO = 'privado';
  const ROL_ADMIN = 'admin';

  protected $_componentesPublicos = [
    'index' => '*',
    'login' => '*',
    'logout' => '*',
    'persona' => '*',
    'Persona' => '*',
    'personas' => '*',
    // 'persona' => 'crear',
    // 'persona' => 'actualizar',
    // 'persona' => 'eliminar',
    // 'persona' => 'encontrar',
    // 'persona' => 'filtrar',
    'municipio' => 'filtrar',
    'municipio' => 'filtrarPorDepartamentos',
    'municipio' => 'filtrarPorDepartamentos',
  ];

  protected $_componentesPrivados = [
    'index' => ['*'],
    'login' => ['*'],
    'logout' => ['*'],
    'persona' => ['crear','actualizar','eliminar','encontrar','filtrar'],
    'municipio' => ['filtrar','filtrarPorDepartamentos','filtrarPorDepartamentos'],
    'dashboard' => ['*']
  ];

  protected $_componentesAdministrativos = [
    'index' => ['*'],
    'login' => ['*'],
    'logout' => ['*'],
    'municipio' => ['filtrar','filtrarPorDepartamentos','filtrarPorDepartamentos'],
    'departamento' => ['*'],
    'tipoDocumento' => ['*'],
    'sexo' => ['*'],
    'dashboard' => ['*'],
    'persona' => ['*']
  ];

  protected function _getAcl() {

    if (!isset($this->persistent->acl)) {
      $acl = new Memory();
      $acl->setDefaultAction(Enum::ALLOW);

      $rolPublico = new Role(self::ROL_PUBLICO, 'Acceso Anónimo');
      $rolPrivado = new Role(self::ROL_PRIVADO, 'Acceso Consulta');
      $rolAdmin = new Role(self::ROL_ADMIN, 'Acceso Administrador');

      $acl->addRole($rolPublico);
      $acl->addRole($rolPrivado);
      $acl->addRole($rolAdmin);

      // Acceso a componentes públicos
      foreach ($this->_componentesPublicos as $component => $action) {
        $acl->addComponent(new Component($component), $action);
      }

      // Acceso a componentes privados
      foreach ($this->_componentesPrivados as $component => $action) {
        $acl->addComponent(new Component($component), $action);
      }

      // Acceso a componentes administrativos
      foreach ($this->_componentesAdministrativos as $component => $action) {
        $acl->addComponent(new Component($component), $action);
      }

      foreach ($acl->getRoles() as $rol) {
        foreach ($this->_componentesPublicos as $componente => $action) {
          // echo '<br>'.$rol->getName() . $componente;
          $acl->allow($rol->getName(), $componente, '*');
        }
      }
      //die;

      // Permitir que los usuarios privados accedan información privada
      foreach ($this->_componentesPrivados as $componente => $actions) {
        foreach ($actions as $action) {
          $acl->allow(self::ROL_PRIVADO, $componente, $action);
          $acl->allow(self::ROL_ADMIN, $componente, $action);
        }
      }

      // Permitir a administradores acceder las funcionalidades de administración
      foreach ($this->_componentesAdministrativos as $componente => $actions) {
        foreach ($actions as $action) {
          // echo '<br>'. $componente . "-" . $action;
          $acl->allow(self::ROL_ADMIN, $componente, $action);
        }
      }
      // die;

      $this->persistent->acl = $acl;
    }

    return $this->persistent->acl;

  }

  public function beforeExecuteRoute(Event $event, Dispatcher $despachador) {

    $rol = $this->session->get('rol');
    if (!$rol) {
      $rol = self::ROL_PUBLICO;
    }

    // Obtener control y acción actuales del despachador
    $controller = $despachador->getControllerName();
    $action = $despachador->getActionName();

    $acl = $this->_getAcl();
    $allowed = $acl->isAllowed($rol, $controller, $action);

    // die($allowed);

    // $this->flash->notice("Con " . $rol . " tiene acceso a " . $controller . " - " . $action . ": " . $allowed);

    if ($allowed != Enum::ALLOW) {
      $this->flash->error("No tiene autorización para acceder esta funcionalidad.");
      
      // Redireccionar a inicio
      $this->response->redirect('index');

      // Impide continuar
      return false;
    }

  }

}