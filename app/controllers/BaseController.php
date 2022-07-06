<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase abstracta con configuraciones comunes para las clases que la extienden.
*/

use \Phalcon\Mvc\Controller;
use \Phalcon\Assets\Filters\Cssmin;
use \Phalcon\Assets\Filters\Jsmin;
use \Phalcon\Tag;

class BaseController extends Controller {

  public function initialize() {

    Tag::prependTitle('EmpresApp | ');

    $this->assets->collection('estilos')
    ->addCss('/terceros/bootstrap/css/bootstrap.min.css', false, false)
    ->addCss('/css/base.css')
    //->setTargetPath('css/produccion.css')
    //->setTargetUri('css/produccion.css')
    //->join(true)
    //->addFilter(new Cssmin())
    ;

    $this->assets->collection('estilosadmin')
    ->addCss('/terceros/bootstrap/css/bootstrap.min.css', false, false)
    ->addCss('/css/base.css')
    ->addCss('/css/admin.css')
    ;
    
    $this->assets->collection('js')
    ->addJs('/terceros/jquery/jquery.min.js', false, false)
    ->addJs('/terceros/bootstrap/js/bootstrap.bundle.min.js', false, false)
    ->addJs('/js/auxiliares.js', false, false)
    //->addJs('js/logica.js')
    //->setTargetPath('js/produccion.js')
    //->setTargetUri('js/produccion.js')
    //->join(true)
    //->addFilter(new Jsmin())
    ;

    $this->assets->collection('js-dashboard')
    ->addJs('/terceros/jquery/jquery.min.js', false, false)
    ->addJs('/terceros/bootstrap/js/bootstrap.bundle.min.js', false, false)
    // ->addJs('/terceros/chart/chart.min.js', false, false)
    // ->addJs('/terceros/feather-icons/feather.min.js', false, false)
    ->addJs('/js/dashboard.js', false, false)
    //->addJs('js/logica.js')
    //->setTargetPath('js/produccion.js')
    //->setTargetUri('js/produccion.js')
    //->join(true)
    //->addFilter(new Jsmin())
    ;

    $phalconVersion = Phalcon\Version::get();
    // die($phalconVersion);

  }

  /*
  public function startSessionAction() {
    $this->session->set('name', 'Jesse');
  }

  public function getSessionAction() {
    echo $this->session->get('name');
  }

  public function removeSessionAction() {
    echo $this->session->remove('name');
  }

  public function destroySessionAction() {
    echo $this->session->destroy();
  }
  */
}