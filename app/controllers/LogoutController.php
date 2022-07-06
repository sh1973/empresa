<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo del cierre de sesión.
*/


use Phalcon\Tag;

class LogoutController extends BaseController {

  public function indexAction() {

    Tag::setTitle('Cerrar Sesión');
    $this->assets->collection('css-login')->addCss('css/logout.css');

  }

  public function salirAction() {
    echo $this->session->destroy();
    echo "Sesión finalizada.";
  }

}