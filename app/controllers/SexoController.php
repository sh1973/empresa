<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo de la tabla y la lógica de sexo.
*/


use Phalcon\Tag;

class SexoController extends BaseController
{

    public function indexAction() {

        Tag::setTitle('Sexos');

        $this->view->setVars([
            'single' => Sexo::findFirstById(8),
            'all' => Sexo::find(),
        ]);
    }

    /*
    public function createAction()
    {
        $persona = new Sexo();

        $persona->nombre = "Pepito Pérez";
        $persona->id_tipo_documento = 1;
        $persona->numero_documento = "80503561";
        $persona->id_municipio = 5001;
        $persona->usuario = "pepito";
        $persona->clave = "clave";

        $resultado = $persona->create();

        if (!$resultado) {
            print_r($persona->getMessages());
        }
    }
    */

    /*
    public function updateAction()
    {
        $persona = Persona::findFirstById(8);
        if (!$persona) {
            die("No existe la persona.");
        }

        $persona->nombre = "Santiago Hernández";
        $resultado = $persona->save();

        if (!$resultado) {
            print_r($persona->getMessages());
        }
    }
    */

    /*
    public function deleteAction()
    {
        $persona = Persona::findFirstById(9);
        if (!$persona) {
            die("No existe la persona.");
        }

        $persona->nombre = "Santiago Hernández";
        $resultado = $persona->delete();

        if (!$resultado) {
            print_r($persona->getMessages());
        }
    }
    */
}
