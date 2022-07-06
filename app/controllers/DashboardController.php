<?php

/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito de esta clase: clase para el manejo del tablero.
*/

use Phalcon\Tag;
use Phalcon\Http\Response;

class DashboardController extends BaseController
{

    public function indexAction() {

        Tag::setTitle('Tablero');

        $this->assets->collection('css-dashboard')->addCss('/css/dashboard.css');
        // $this->assets->collection('js-dashboard')
        // ->addCss('/js/terceros/charts/loader.js')
        // ->addCss('/js/dashboard.js');

        $this->assets->addCss('/css/dashboard.css');
        // $this->assets->addJs('/js/terceros/charts/loader.js');
        $this->assets->addJs('https://www.gstatic.com/charts/loader.js');
        $this->assets->addJs('/js/dashboard.js');

        $roles = ['publico', 'privado', 'admin'];

        // $personasDTO = $this->filtrarPersonasTablero();

        $this->view->setVars([
            // 'personasDTO' => $personasDTO,
            'roles'=> $roles,
            'tipos_documento' => TipoDocumento::find(),
            'departamentos' => Departamento::find(),
            'municipios' => Municipio::find(),
            'sexos' => Sexo::find()
        ]);

    }

    public function refrescarTableroAction() {
        $this->view->disable();

        $response = new Response();
        $response->setContentType('application/json', 'UTF-8');

        $personasDTO = $this->filtrarPersonasTablero();
        $conteoPersonasPorSexoDTO = $this->conteoPersonasPorSexo();
        $conteoPersonasPorTipoDocumentoDTO = $this->conteoPersonasPorTipoDocumento();

        $data = [$personasDTO, $conteoPersonasPorSexoDTO, $conteoPersonasPorTipoDocumentoDTO];
            
        $response->setContent(json_encode($data));

        return $response;
    }

    
    public function conteoPersonasPorSexo() {
        $tipos_documento = $this->request->getQuery('tipos_documento');
        $sexos = $this->request->getQuery('sexos');
        $departamentos = $this->request->getQuery('departamentos');
        $municipios = $this->request->getQuery('municipios');

        $w_tipos_documento = "";
        if ($tipos_documento) {
            $w_tipos_documento = " and p.id_tipo_documento in (" . $tipos_documento . ") ";
        }
        $w_sexos = "";
        if ($sexos) {
            $w_sexos = " and p.id_sexo in (" . $sexos . ") ";
        }
        $w_departamentos = "";
        if ($departamentos) {
            $w_departamentos = " and d.id in (" . $departamentos . ") ";
        }
        $w_municipios = "";
        if ($municipios) {
            $w_municipios = " and p.id_municipio in (" . $municipios . ") ";
        }

        $sql = "select s.nombre as nombre, count(*) as conteo
        from persona p
        inner join municipio m on p.id_municipio =m.id
        inner join departamento d on m.id_departamento =d.id
        inner join sexo s on p.id_sexo =s.id
        inner join tipo_documento t on p.id_tipo_documento =t.id
        where (eliminado=0 or eliminado is null) "
        . $w_tipos_documento
        . $w_sexos
        . $w_departamentos
        . $w_municipios
        . " group by s.nombre "
        ;

        $conteoPersonasPorSexoDTO = array();
        $rs = $this->db->query($sql);

        if ($rs) {
            while ($r = $rs->fetchArray()) {
                $dto = array();
                $dto['nombre'] = $r['nombre'];
                $dto['conteo'] = $r['conteo'];
                $conteoPersonasPorSexoDTO[] =  $dto;
            }
        }

        return $conteoPersonasPorSexoDTO;
    }

    public function conteoPersonasPorTipoDocumento() {
        $tipos_documento = $this->request->getQuery('tipos_documento');
        $sexos = $this->request->getQuery('sexos');
        $departamentos = $this->request->getQuery('departamentos');
        $municipios = $this->request->getQuery('municipios');

        $w_tipos_documento = "";
        if ($tipos_documento != '') {
            $w_tipos_documento = " and p.id_tipo_documento in (" . $tipos_documento . ") ";
        }
        $w_sexos = "";
        if ($sexos != '') {
            $w_sexos = " and p.id_sexo in (" . $sexos . ") ";
        }
        $w_departamentos = "";
        if ($departamentos != '') {
            $w_departamentos = " and d.id in (" . $departamentos . ") ";
        }
        $w_municipios = "";
        if ($municipios != '') {
            $w_municipios = " and p.id_municipio in (" . $municipios . ") ";
        }

        $sql = "select t.nombre as nombre, count(*) as conteo
        from persona p
        inner join municipio m on p.id_municipio =m.id
        inner join departamento d on m.id_departamento =d.id
        inner join sexo s on p.id_sexo =s.id
        inner join tipo_documento t on p.id_tipo_documento =t.id
        where (eliminado=0 or eliminado is null) "
        . $w_tipos_documento
        . $w_sexos
        . $w_departamentos
        . $w_municipios
        . " group by t.nombre "
        ;

        $conteoPersonasPorSexoDTO = array();
        $rs = $this->db->query($sql);

        if ($rs) {
            while ($r = $rs->fetchArray()) {
                $dto = array();
                $dto['nombre'] = $r['nombre'];
                $dto['conteo'] = $r['conteo'];
                $conteoPersonasPorSexoDTO[] =  $dto;
            }
        }

        return $conteoPersonasPorSexoDTO;
    }

    public function filtrarPersonasTablero() {
        $tipos_documento = $this->request->getQuery('tipos_documento');
        $sexos = $this->request->getQuery('sexos');
        $departamentos = $this->request->getQuery('departamentos');
        $municipios = $this->request->getQuery('municipios');

        $w_tipos_documento = "";
        if ($tipos_documento != '') {
            $w_tipos_documento = " and p.id_tipo_documento in (" . $tipos_documento . ") ";
        }
        $w_sexos = "";
        if ($sexos) {
            $w_sexos = " and p.id_sexo in (" . $sexos . ") ";
        }
        $w_departamentos = "";
        if ($departamentos != '') {
            $w_departamentos = " and d.id in (" . $departamentos . ") ";
        }
        $w_municipios = "";
        if ($municipios != '') {
            $w_municipios = " and p.id_municipio in (" . $municipios . ") ";
        }

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
        inner join municipio m on p.id_municipio =m.id
        inner join departamento d on m.id_departamento =d.id
        inner join sexo s on p.id_sexo =s.id
        inner join tipo_documento t on p.id_tipo_documento =t.id
        where (eliminado=0 or eliminado is null) "
        . $w_tipos_documento
        . $w_sexos
        . $w_departamentos
        . $w_municipios
        . " order by p.nombre";

        $personasDTO = array();
        $rs = $this->db->query($sql);

        while ($r = $rs->fetchArray()) {
            $personaDTO = array();
            $personaDTO['id'] = $r['id'];
            $personaDTO['nombre'] = $r['nombre'];
            $personaDTO['numero_documento'] = $r['numero_documento'];
            $personaDTO['tipo_documento'] = $r['tipo_documento'];
            $personaDTO['municipio'] = $r['municipio'];
            $personaDTO['sexo'] = $r['sexo'];
            $personaDTO['usuario'] = $r['usuario'];
            $personaDTO['rol'] = $r['rol'];
            $personaDTO['creacion'] = $r['creacion'];
            $personaDTO['modificacion'] = $r['modificacion'];

            $personasDTO[] = $personaDTO;
        }

        return $personasDTO;
    }

    public function exportarExcelAction() {

        $personasDTO = $this->filtrarPersonasTablero();
        
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
            <td style='$data_css'>" . $personaDTO['id'] . "</td>
            <td style='$data_css'>" . $personaDTO['nombre'] . "</td>
            <td style='$data_css'>" . $personaDTO['tipo_documento'] . "</td>
            <td style='$data_css'>" . $personaDTO['numero_documento'] . "</td>
            <td style='$data_css'>" . $personaDTO['municipio'] . "</td>
            <td style='$data_css'>" . $personaDTO['sexo'] . "</td>
            <td style='$data_css'>" . $personaDTO['usuario'] . "</td>
            <td style='$data_css'>" . $personaDTO['rol'] . "</td>
            <td style='$data_css'>" . $personaDTO['creacion'] . "</td>
            <td style='$data_css'>" . $personaDTO['modificacion'] . "</td>
            </tr>";
        }
        $table.= '</table>';
    
        header ("Content-type: application/xls;charset=UTF-8");
        header ("Content-Disposition: attachment; filename=Personas-Filtradas-" .date("Y-m-d H:i:s"). ".xls" );
    
        return $table;
    } 

}

