<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: manejo de funcionalidades de administración.
*/

use \Phalcon\Tag;

class AdminController extends BaseController {

  public function indexAction() {

    Tag::setTitle('Administración');
    
    echo "Administracion";
    die;

  }

}