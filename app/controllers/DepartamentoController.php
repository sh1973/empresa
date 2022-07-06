<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo de departamentos.
*/


use Phalcon\Tag;

class DepartamentoController extends BaseController
{

    public function indexAction() {
        
        Tag::setTitle('Departamentos');

        $this->view->setVars([
            'single' => Departamento::findFirstById(1),
            'all' => Departamento::find(),
        ]);
    }
}
