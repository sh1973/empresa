<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase del modelo de departamento.
*/


use Phalcon\Mvc\Model;

class Departamento extends Model
{
    public $id;
    public $nombre;
    public $codigo;

    public function initialize() {
      $this->hasMany('id', 'Municipio', 'id_departamento');

    }
}