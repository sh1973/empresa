<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo del componente de inicio.
*/


use \Phalcon\Tag;

class IndexController extends BaseController {

  public function indexAction() {

    Tag::setTitle('Inicio');

  }

  public function encriptarClaveAction($password) {
    echo $this->security->hash($password);
  }

  public function startSessionAction() {
    $this->session->set('name', 'Jesse');
  }

  public function getSessionAction() {
    echo $this->session->get('name');
  }

  public function removeSessionAction() {
    echo $this->session->remove('name');
  }

}