<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase DTO para desplegar versión legible de personas.
*/

use Phalcon\Mvc\Model;

class PersonaDTO extends Model
{
  public $id;
  public $nombre;
  public $tipo_documento;
  public $numero_documento;
  public $municipio;
  public $sexo;
  public $usuario;
  public $rol;
  public $creacion;
  public $modificacion;
}