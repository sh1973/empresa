<?php
/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase abstracta del modelo base que extienden las demás.
*/


use Phalcon\Mvc\Model;

class BaseModel extends Model
{
    public function initialize()
    {
        // $this->getModelsManager()->setModelSchema($this, "public");
    }

    public function beforeCreate() {
      $this->creacion = date('Y-m-d H:i:s');
    }

    public function beforeUpdate() {
      $this->modificacion = date('Y-m-d H:i:s');
    }

    public function beforeDelete() {
      $this->eliminacion = date('Y-m-d H:i:s');
    }
}