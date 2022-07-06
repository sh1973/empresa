<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase del modelo de tipo de documento.
*/

use Phalcon\Mvc\Model;

class TipoDocumento extends Model
{
    public $id;
    public $nombre;
    public $abreviatura;

    public function initialize() {
      $this->hasMany('id', 'Persona', 'id_tipo_documento');
    }
}