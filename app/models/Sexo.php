<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase del modelo de sexo.
*/

use Phalcon\Mvc\Model;

class Sexo extends Model
{
    public $id;
    public $nombre;

    public function initialize() {
      $this->hasMany('id', 'Persona', 'id_sexo');

    }
}