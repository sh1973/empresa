<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase del modelo de persona.
*/

use Phalcon\Mvc\Model;
use Phalcon\Mvc\Model\Behavior\SoftDelete;
/*
use Phalcon\Messages\Message;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Phalcon\Validation\Validator\InclusionIn;
use Phalcon\Validation\Validator\PresenceOf;
*/

class Persona extends BaseModel
{
  public $id;
  public $nombre;
  public $numero_documento;
  public $usuario;
  public $clave;

  public function initialize() { 
    // $this->setSource('persona'); 
    $this->belongsTo('id_tipo_documento', 'TipoDocumento', 'id');
    $this->belongsTo('id_municipio', 'Municipio', 'id');
    $this->belongsTo('id_sexo', 'Sexo', 'id');

    $this->addBehavior(new SoftDelete([
      'field' => 'eliminado',
      'value' => 1,
    ]));
  }

  public function beforeCreate() {
    $tipo_documento = TipoDocumento::findFirstById($this->id_tipo_documento);

    if ($tipo_documento) {
      $this->usuario = $tipo_documento->abreviatura . "-" . $this->numero_documento;
    }
    else {
      $this->usuario = $this->id_tipo_documento . "-" . $this->numero_documento;
    }

  }

  public function beforeUpdate() {
    $tipo_documento = TipoDocumento::findFirstById($this->id_tipo_documento);

    if ($tipo_documento) {
      $this->usuario = $tipo_documento->abreviatura . "-" . $this->numero_documento;
    }
    else {
      $this->usuario = $this->id_tipo_documento . "-" . $this->numero_documento;
    }
  }

  public function beforeValidationOnCreate() {
    if ($this->clave == '') {
      $this->flash->warning('La clave es obligatoria.');
      return false;
    }
    if (strlen($this->clave) < 8) {
      $this->flash->warning('La clave debe tener mínimo 8 caracteres.');
      return false;
    }
  }


  /*
  
    public function validation()
    {
        $validator = new Validation();
        
        $validator->add(
            "id_tipo_documento",
            new InclusionIn(
                [
                    'message' => 'El tipo de documento debe ser Cédula de Ciudadanía, Cédula de Extranjería, Tarjeta de Identidad, Registro Civil',
                    'domain' => [
                        '1',
                        '2',
                        '3',
                        '4',
                    ],
                ]
            )
        );

        $validator->add(
          'numero_documento',
          new Uniqueness(
              [
                  'field'   => 'numero_documento',
                  'message' => 'El nombre completo debe ser único',
              ]
          )
        );

        $validator->add(
            'nombre',
            new Uniqueness(
                [
                    'field'   => 'nombre',
                    'message' => 'El nombre completo debe ser único',
                ]
            )
        );

        $validator->add(
          'id_municipio',
          new PresenceOf([
            'message' => 'El :field es necesario',
          ])
        );

        $validator->add(
          'login',
          new PresenceOf([
            'message' => 'El :field es necesario',
          ])
        );

        $validator->add(
          'clave',
          new PresenceOf([
            'message' => 'El :field es necesario',
          ])
        );

        // if ($this->year < 0) {
        //     $this->appendMessage(
        //         new Message('The year cannot be less than zero')
        //     );
        // }
        
        // Validate the validator
        return $this->validate($validator);
    }
    */
}