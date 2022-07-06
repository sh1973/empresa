<?php 

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: definir las rutas de acceso.
*/

use Phalcon\Mvc\Router\Group;

class GlobalRoutes extends Group {

  public function initialize() {
    // Listar todas las personas
    $this->addGet("/products", array(
      'controller' => 'Persona',
      'action' => 'listar'
    ));

    // Encontrar personas
    $this->addGet("/personas/filtrar/:params", [
      'controller'  => 'Persona',
      'action'      => 'filtrar',
      'params'      => 1,
    ]);

    // Encontrar una persona por id
    $this->addGet("/personas/encontrar/:params", [
      'controller' => 'Persona',
      'action' => 'encontrar',
      'params' => 1,
    ]);
    
    // Create una persona
    $this->addPost('/personas/crear/:params', [
      'controller' => 'Persona',
      'action' => 'crear',
      'nombre' => 1,
      'id_tipo_documento' => 2,
      'numero_documento' => 3,
      'id_municipio' => 4,
      'id_sexo' => 5,
      'usuario' => 6,
      'clave' => 7,
      'rol' => 8,
    ]);
    
    // Actualizar una persona
    $this->addPut("/personas/actualizar/:params", [
      'controller' => 'Persona',
      'action' => 'actualizar',
      'nombre' => 1,
      'id_tipo_documento' => 2,
      'numero_documento' => 3,
      'id_municipio' => 4,
      'id_sexo' => 5,
      'usuario' => 6,
      'clave' => 7,
      'rol' => 8,
      'id' => 9,
    ]);

    // Eliminar el registro de una persona
    $this->addDelete("/personas/eliminar/:params", [
      'controller' => 'Persona',
      'action' => 'eliminar',
      'params' => 1,
    ]);
    
    /*

    $this->notFound(array(
      'controller' => 'index',
      'action' => 'notFound'
    ));
    */

    // $this->removeExtraSlashes(true);
    // return $this;
  }

}