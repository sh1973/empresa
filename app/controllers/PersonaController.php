<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo de personas.
*/


use Phalcon\Tag;
use Phalcon\Http\Response;

class PersonaController extends BaseController
{
    public function indexAction() {

        Tag::setTitle('Persona');

        $this->session->set('usuario', 'Usuario');


        // $personasDTO = $this->modelsManager->executeQuery($sql);

        // var_dump($personasDTO);
        // die;

        $roles = ['publico', 'privado', 'admin'];

        $personasDTO = $this->filtrarPersonasAction();

        $this->view->setVars([
            'persona' => Persona::findFirstById($this->request->getQuery('id')),
            'personas' => Persona::find(['eliminado=0 or eliminado is null']),
            'personasDTO' => $personasDTO,
            'roles'=> $roles,
            'tipos_documento' => TipoDocumento::find(),
            'departamentos' => Departamento::find(),
            'municipios' => Municipio::find(),
            'sexos' => Sexo::find()
        ]);
    }

    public function filtrarPersonasAction() {
        $sql = "select 
        p.id as id
        , p.nombre as nombre
        , t.abreviatura as tipo_documento
        , p.numero_documento as numero_documento
        , concat(m.nombre, ' (', d.nombre, ')') as municipio
        , s.nombre as sexo
        , p.usuario as usuario
        , p.rol as rol
        , p.creacion as creacion
        , p.modificacion as modificacion
        from persona p
        left outer join municipio m on p.id_municipio =m.id
        left outer join departamento d on m.id_departamento =d.id
        left outer join sexo s on p.id_sexo =s.id
        left outer join tipo_documento t on p.id_tipo_documento =t.id
        where (eliminado=0 or eliminado is null)
        order by p.nombre";

        $personasDTO = array();
        $rs = $this->db->query($sql);

        while ($r = $rs->fetchArray()) {
            $personaDTO = new PersonaDTO();
            $personaDTO->id = $r['id'];
            $personaDTO->nombre = $r['nombre'];
            $personaDTO->numero_documento = $r['numero_documento'];
            $personaDTO->tipo_documento = $r['tipo_documento'];
            $personaDTO->municipio = $r['municipio'];
            $personaDTO->sexo = $r['sexo'];
            $personaDTO->usuario = $r['usuario'];
            $personaDTO->rol = $r['rol'];
            $personaDTO->creacion = $r['creacion'];
            $personaDTO->modificacion = $r['modificacion'];

            $personasDTO[] = $personaDTO;
        }
        return $personasDTO;
    }

    public function listarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $personas = Persona::find();
        if($personas) {
            $data = [];
            foreach ($personas as $persona) {
                $data[] = [
                  'id'   => $persona->id,
                  'nombre' => $persona->nombre,
                  'id_tipo_documento' => $persona->id_tipo_documento,
                  'numero_documento' => $persona->numero_documento,
                  'id_municipio' => $persona->id_municipio,
                  'usuario' => $persona->usuario,
                  'clave' => $persona->clave,
                  'creacion' => $persona->creacion,
                  'modificacion' => $persona->modificacion,
                  'rol' => $persona->rol,
                ];
            }

            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }

        return $response;
    }

    public function filtrarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $texto =  $this->dispatcher->getParams()[0];

        $personas = Persona::find(" (lower(nombre) like " . "'%" . strtolower($texto) . "%'  or numero_documento like '%" . $texto . "%') and (eliminado=0 or eliminado is null)");
        if($personas) {
            $data = [];
            foreach ($personas as $persona) {
                $data[] = [
                  'id'   => $persona->id,
                  'nombre' => $persona->nombre,
                  'id_tipo_documento' => $persona->id_tipo_documento,
                  'numero_documento' => $persona->numero_documento,
                  'id_municipio' => $persona->id_municipio,
                  'usuario' => $persona->usuario,
                  'clave' => $persona->clave,
                  'creacion' => $persona->creacion,
                  'modificacion' => $persona->modificacion,
                  'rol' => $persona->rol,
                ];
            }

            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }

        return $response;
    }

    public function encontrarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $codigo =  $this->dispatcher->getParams()[0];

        $persona = Persona::findFirst(" (id=" . $codigo . " or numero_documento like '%" . $codigo . "%') and (eliminado=0 or eliminado is null) ");
        if($persona) {
            $data[] = [
                'id'   => $persona->id,
                'nombre' => $persona->nombre,
                'id_tipo_documento' => $persona->id_tipo_documento,
                'numero_documento' => $persona->numero_documento,
                'id_municipio' => $persona->id_municipio,
                'usuario' => $persona->usuario,
                'clave' => $persona->clave,
                'creacion' => $persona->creacion,
                'modificacion' => $persona->modificacion,
                'rol' => $persona->rol,
            ];

            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }

        return $response;
    }

    public function crearAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $json = $this->request->getJsonRawBody();

        $nombre = $json->nombre;
        $id_tipo_documento = $json->id_tipo_documento;
        $numero_documento = $json->numero_documento;
        $id_municipio = $json->id_municipio;
        $id_sexo = $json->id_sexo;
        $usuario = $json->usuario;
        $clave = $json->clave;
        $rol = $json->rol;

        $persona = new Persona();
        $persona->nombre = $nombre;
        $persona->id_tipo_documento = $id_tipo_documento;
        $persona->numero_documento = $numero_documento;
        $persona->id_municipio = $id_municipio;
        $persona->id_sexo = $id_sexo;
        $persona->usuario = $usuario;
        $persona->clave = $clave;
        $persona->rol = $rol;

        // var_dump($persona); die;

        $resultado = $persona->create();

        if ($resultado) {
            $persona = Persona::findFirst(" (numero_documento = '" . $numero_documento . "') ");
            if($persona) {
                $data[] = [
                    'id'   => $persona->id,
                    'nombre' => $persona->nombre,
                    'id_tipo_documento' => $persona->id_tipo_documento,
                    'numero_documento' => $persona->numero_documento,
                    'id_municipio' => $persona->id_municipio,
                    'usuario' => $persona->usuario,
                    'clave' => $persona->clave,
                    'creacion' => $persona->creacion,
                    'modificacion' => $persona->modificacion,
                    'rol' => $persona->rol,
                ];

                $response->setContent(json_encode($data));
            } else {
                $response->setStatusCode(204, 'No Content');
            }
        }
        return $response;
    }

    public function actualizarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $json = $this->request->getJsonRawBody();
        $id = $json->id;

        if (!$id) {
            $response->setStatusCode(400, 'Bad Request');
            return $response;
        }

        $nombre = $json->nombre;
        $id_tipo_documento = $json->id_tipo_documento;
        $numero_documento = $json->numero_documento;
        $id_municipio = $json->id_municipio;
        $id_sexo = $json->id_sexo;
        $usuario = $json->usuario;
        $clave = $json->clave;
        $rol = $json->rol;

        $persona = Persona::findFirstById($id);

        if (!$persona) {
            $response->setStatusCode(204, 'No Content');
            return $response;
        }

        $persona->nombre = $nombre;
        $persona->id_tipo_documento = $id_tipo_documento;
        $persona->numero_documento = $numero_documento;
        $persona->id_municipio = $id_municipio;
        $persona->id_sexo = $id_sexo;
        $persona->usuario = $usuario;
        $persona->clave = $clave;
        $persona->rol = $rol;

        $resultado = $persona->save();

        if ($resultado) {
            $persona = Persona::findFirst(" (numero_documento = '" . $numero_documento . "') ");
            if($persona) {
                $data[] = [
                    'id'   => $persona->id,
                    'nombre' => $persona->nombre,
                    'id_tipo_documento' => $persona->id_tipo_documento,
                    'numero_documento' => $persona->numero_documento,
                    'id_municipio' => $persona->id_municipio,
                    'usuario' => $persona->usuario,
                    'clave' => $persona->clave,
                    'creacion' => $persona->creacion,
                    'modificacion' => $persona->modificacion,
                    'rol' => $persona->rol,
                ];

                $response->setContent(json_encode($data));
            } else {
                $response->setStatusCode(204, 'No Content');
            }
        }
        return $response;
    }

    public function eliminarAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $id = $this->dispatcher->getParams()[0];

        if (!$id) {
            $response->setStatusCode(400, 'Bad Request');
            return $response;
        }

        $persona = Persona::findFirstById($id);

        if (!$persona) {
            $response->setStatusCode(204, 'No Content');
            return $response;
        }

        $resultado = $persona->delete();

        if ($resultado) {
            $data = 1;
            $response->setContent(json_encode($data));
        } else {
            $response->setStatusCode(204, 'No Content');
        }
        return $response;
    }

    public function saveAction() {

        $persona = null;

        $id = $this->request->getPost('id');
        if ($id) {
            $persona = Persona::findFirstById($id);
        }

        if (!$persona) {
            $tipo_documento = TipoDocumento::findFirstById($this->request->getPost('id_tipo_documento'));
            if ($tipo_documento) {
              $usuario = $tipo_documento->abreviatura . "-" . $this->request->getPost('numero_documento');
            }
            else {
              $usuario = $this->request->getPost('id_tipo_documento') . "-" . $this->request->getPost('numero_documento');
            }
            // var_dump($usuario);die;
            $persona = Persona::findFirstByUsuario($usuario);
        }

        if (!$persona) {
            $nombre = $this->request->getPost('nombre');
            // var_dump($nombre);die;
            $persona = Persona::findFirstByNombre($nombre);
        }

        if (!$persona) {
            $this->flash->notice("Creando persona");
            $ok = $this->createAction();
        }
        else {
            $ok = $this->updateAction($persona->id);
        }

        if ($ok) {
            $this->flash->success("¡La persona se pudo guardar!");
        }
        else {
            $this->flash->error("¡La persona no se pudo guardar!");
        }

        $this->response->redirect("persona");

    }

    public function createAction() {
        
        $persona = new Persona();
        
        $persona->nombre = $this->request->getPost('nombre');
        $persona->id_tipo_documento = $this->request->getPost('id_tipo_documento');
        $persona->numero_documento = $this->request->getPost('numero_documento');
        $persona->id_municipio = $this->request->getPost('id_municipio');
        $persona->id_sexo = $this->request->getPost('id_sexo');
        $persona->usuario = $this->request->getPost('usuario');
        $tipo_documento = TipoDocumento::findFirstById($this->id_tipo_documento);
        if ($tipo_documento) {
          $persona->usuario = $tipo_documento->abreviatura . "-" . $this->numero_documento;
        }
        else {
          $persona->usuario = $this->id_tipo_documento . "-" . $this->numero_documento;
        }
    
        $clave = $this->request->getPost('clave');
        $clave_confirmacion = $this->request->getPost('clave_confirmacion');
        if ($clave != $clave_confirmacion) {
            $this->flash->warning("No coincide la clave de confirmación.");
            $this->response->redirect('/persona');
            return;
        }
        if ($clave != '') {
            $persona->clave = $this->security->hash($clave);
        }
        else {
            $this->flash->error("¡La clave es necesaria!");
            return false;
        }

        $persona->rol = $this->request->getPost('rol');

        $resultado = $persona->create();
        
        if (!$resultado) {
            print_r($persona->getMessages());
            return false;
        }

        return true;
    }

    public function updateAction($id) {
        // $id = $this->request->getPost('id');

        $persona = Persona::findFirstById($id);

        if (!$persona) {
            die("No existe la persona.");
        }

        $persona->nombre = $this->request->getPost('nombre');
        $persona->id_tipo_documento = $this->request->getPost('id_tipo_documento');
        $persona->numero_documento = $this->request->getPost('numero_documento');
        $persona->id_municipio = $this->request->getPost('id_municipio');
        $persona->id_sexo = $this->request->getPost('id_sexo');
        $persona->usuario = $this->request->getPost('usuario');
        $tipo_documento = TipoDocumento::findFirstById($this->id_tipo_documento);
        if ($tipo_documento) {
          $persona->usuario = $tipo_documento->abreviatura . "-" . $this->numero_documento;
        }
        else {
          $persona->usuario = $this->id_tipo_documento . "-" . $this->numero_documento;
        }

        $clave = $this->request->getPost('clave');
        $clave_confirmacion = $this->request->getPost('clave_confirmacion');
        if ($clave != $clave_confirmacion) {
            $this->flash->warning("No coincide la clave de confirmación.");
            $this->response->redirect('/persona?id'.$id);
            return;
        }
        if ($clave != '') {
            $persona->clave = $this->security->hash($clave);
        }
        
        $persona->rol = $this->request->getPost('rol');
        $persona->eliminado = "0";

        $resultado = $persona->save();
        
        if (!$resultado) {
            print_r($persona->getMessages());
            return false;
        }

        return true;
    }

    public function deleteAction() {
        $ok = true;

        $id = $this->request->getQuery('id');
        if ($id) {
            if ($id == 1) {
                $this->flash->notice("No se puede eliminar el usuario inicial");
                $this->response->redirect("persona");
                return;
            }

            $persona = Persona::findFirstById($id);

            if (!$persona) {
                die("No existe la persona.");
                $ok = true;
            }

            $resultado = $persona->delete();
            
            if (!$resultado) {
                print_r($persona->getMessages());
                $ok = false;
            }
        }

        if ($ok) {
            $this->response->redirect("persona");
        }
    }
 
    public function exportarExcelAction() {

        $personasDTO = $this->filtrarPersonasAction();
        
        //Declaring css
        $header_css = "";
        $data_css = "";

        $table = "<table>
        <tr>
        <td style='$header_css'>ID</td>
        <td style='$header_css'>Nombre Completo</td>
        <td style='$header_css'>Tipo Documento</td>
        <td style='$header_css'>Municipio</td>
        <td style='$header_css'>Sexo</td>
        <td style='$header_css'>Usuario</td>
        <td style='$header_css'>Rol</td>
        <td style='$header_css'>Creacion</td>
        <td style='$header_css'>Modificacion</td>
        </tr>";
        foreach ($personasDTO as $personaDTO) {
            $table.= "<tr>
            <td style='$data_css'>$personaDTO->id</td>
            <td style='$data_css'>$personaDTO->nombre</td>
            <td style='$data_css'>$personaDTO->tipo_documento</td>
            <td style='$data_css'>$personaDTO->numero_documento</td>
            <td style='$data_css'>$personaDTO->municipio</td>
            <td style='$data_css'>$personaDTO->sexo</td>
            <td style='$data_css'>$personaDTO->usuario</td>
            <td style='$data_css'>$personaDTO->rol</td>
            <td style='$data_css'>$personaDTO->creacion</td>
            <td style='$data_css'>$personaDTO->modificacion</td>
            </tr>";
        }
        $table.= '</table>';

        header ("Content-type: application/xls;charset=UTF-8");
        header ("Content-Disposition: attachment; filename=Personas-" .date("Y-m-d H:i:s"). ".xls" );

        return $table;
    } 

}