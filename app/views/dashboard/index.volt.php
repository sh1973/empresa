

<!doctype html>
<html lang="es" class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $this->tag->getTitle() ?></title>
  <?= $this->assets->outputCss('estilos') ?>
  <?= $this->assets->outputJs('js') ?>
  
    <?= $this->assets->outputCss('css-dashboard') ?>

</head>
<body class="d-flex flex-column h-100">

<header class="no-print">
  <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">EmpresApp</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav me-auto mb-2 mb-md-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/#">Inicio</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdownAdministracion" data-bs-toggle="dropdown" aria-expanded="false">Administración</a>
            <ul class="dropdown-menu" aria-labelledby="dropdownAdministracion">
              <li><a class="dropdown-item" href="/persona/index">Personas</a></li>
            </ul>
          </li>          
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a class="nav-link" href="<?= $this->url->get('logout') ?>">Salir</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<?= $this->flash->output() ?>



<div class="div_titulo_informe">
  <h1>Informe Estadístico de Personas</h1>
  <input type="button" class="boton_impresion no-print" value="Imprimir" onclick="window.print()" />
</div>
<div class="div_contenedor_filtros_y_tablero">
  <div class="div_formulario_filtros">
    <form class="form_filtros">
      <h4>Filtros</h4>
      <span class="span_etiqueta">Tipos de Documento</span>
      <div id="filtro_tipos_documento">
      <?php foreach ($tipos_documento as $tipoDocumento) { ?>
        <br/><input type="checkbox" name="tipos_documento" value="<?= $tipoDocumento->id ?>" unchecked  onclick="refrescarTablero()" /><?= $tipoDocumento->nombre ?>
      <?php } ?>
      </div>
      <br/>
      <br/>
      <span class="span_etiqueta">Sexos</span>
      <div id="filtro_sexos">
      <?php foreach ($sexos as $sexo) { ?>
        <br/><input type="checkbox" name="sexos" value="<?= $sexo->id ?>" unchecked onclick="refrescarTablero()" /><?= $sexo->nombre ?>
      <?php } ?>
      </div>
      <br/>
      <br/>
      <span class="span_etiqueta">Departamentos</span>
      <div id="filtro_departamentos">
      <?php foreach ($departamentos as $departamento) { ?>
        <br/><input type="checkbox" name="departamentos" value="<?= $departamento->id ?>" unchecked onclick="filtrarMunicipiosDepartamentos()" /><?= $departamento->nombre ?>
      <?php } ?>
      </div>
      <br/>
      <br/>
      <span class="span_etiqueta">Municipios</span>
      <div id="filtro_municipios"></div>
      <br/>
      <br/>
    </form>
  </div>

  <div class="div_contenedor_tablero">
    <div class="div_graficos_tablero">
      <div id="graficoConteoPersonasPorSexo" class="div_grafico" style="width: 200px; height: 400px;"></div>
      <div id="graficoConteoPersonasPorTipoDocumento" class="div_grafico" style="width: 200px; height: 400px;"></div>
    </div>
    <div id="div_registros" class="div_registros"></div>
    <input type="button" class="boton_impresion no-print" value="Exportar a Excel" onclick="exportarExcel();" />
  </div>
</div>




<footer class="footer mt-auto py-3 bg-light">
  <div class="container flex">
    <div class="text-muted">Secretaría Distrital de Cultura, Recreación y Deporte</div>
    <div class="text-muted">Usuario/a:<?= $this->session->get('nombre') ?>; Rol: <?= $this->session->get('rol') ?></div>
  </div>
</footer>

</body>
</html>