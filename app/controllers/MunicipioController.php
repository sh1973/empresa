<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo de municipios.
*/


use Phalcon\Tag;
use Phalcon\Http\Response;

class MunicipioController extends BaseController
{

    public function indexAction() {

        Tag::setTitle('Municipios');

        $this->view->setVars([
            'single' => Municipio::findFirstById(8),
            'all' => Municipio::find(),
        ]);
    }

    public function filtrarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $id_departamento =  $this->dispatcher->getParams()[0];

        if ($id_departamento) {
            $municipios = Municipio::find(" (id_departamento = " . $id_departamento . ") ");
        }
        else {
            $municipios = Municipio::find();
        }

        if($municipios) {
            $data = [];
            foreach ($municipios as $municipio) {
                $data[] = [
                  'id'   => $municipio->id,
                  'nombre' => $municipio->nombre,
                ];
            }

            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }

        return $response;
    }

    public function filtrarPorDepartamentosAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $departamentos =  $this->dispatcher->getParams()[0];

        if ($departamentos != "") {
            $municipios = Municipio::find(" (id_departamento in (" . $departamentos . ")) ");
        }

        if($municipios) {
            $data = [];
            foreach ($municipios as $municipio) {
                $data[] = [
                  'id'   => $municipio->id,
                  'nombre' => $municipio->nombre,
                ];
            }

            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }

        return $response;
    }


}
