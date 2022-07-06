<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase del modelo de municipio.
*/

use Phalcon\Mvc\Model;

class Municipio extends Model
{
    public $id;
    public $nombre;
    public $codigo;

    public function initialize() {
        $this->hasMany('id', 'Persona', 'id_municipio');
        $this->belongsTo('id_departamento', 'Departamento', 'id');

    }
}