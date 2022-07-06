

<!doctype html>
<html lang="es" class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $this->tag->getTitle() ?></title>
  <?= $this->assets->outputCss('estilosadmin') ?>
  <?= $this->assets->outputJs('js') ?>
</head>
<body class="d-flex flex-column h-100">

<header>
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
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="dashboard">Tablero</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdownAdministracion" data-bs-toggle="dropdown" aria-expanded="false">Administración</a>
            <ul class="dropdown-menu" aria-labelledby="dropdownAdministracion">
              <li><a class="dropdown-item" href="/persona">Personas</a></li>
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



<main class="form-admin w-100 m-auto">
    <div class="div_form">
        <form action="<?= $this->url->get('persona/save') ?>" method="post">
            <h1 class="h3 mb-3 fw-normal">Crear o editar persona:</h1>

            <div class="form-floating">
                <input type="number" class="form-control" name="id" id="id" placeholder="id" value="<?= $persona->id ?>" readonly />
                <label for="id">Identificador</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre completo de documento" value="<?= $persona->nombre ?>" />
                <label for="nombre">Nombre Completo</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_tipo_documento" id="id_tipo_documento" value="<?= $persona->id_tipo_documento ?>">
                    <?php if ((!$persona)) { ?>
                        <option value="" selected></option>
                    <?php } ?>
                    <?php foreach ($tipos_documento as $tipoDocumento) { ?>
                        <option value=<?= $tipoDocumento->id ?>><?= $tipoDocumento->nombre ?></option>
                    <?php } ?>
                </select>
                <label for="id_tipo_documento">Tipo de Documento</label>
            </div>
            <div class="form-floating">
                <input type="number" class="form-control" name="numero_documento" id="numero_documento" placeholder="Número de documento" value="<?= $persona->numero_documento ?>" />
                <label for="numero_documento">Número de Documento</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_departamento" id="id_departamento" value="" onchange="filtrarMunicipios(this.value);">
                    <option value="" selected></option>
                    <?php foreach ($departamentos as $departamento) { ?>
                        <option value=<?= $departamento->id ?>
                        ><?= $departamento->nombre ?></option>
                    <?php } ?>
                </select>
                <label for="id_departamento">Departamento</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_municipio" id="id_municipio" value="<?= $persona->id_municipio ?>">
                    <?php if ((!$persona)) { ?>
                        <option value="" selected></option>
                    <?php } ?>
                    <?php foreach ($municipios as $municipio) { ?>
                        <option value=<?= $municipio->id ?>
                        <?php if (($municipio->id == $persona->id_municipio)) { ?>
                            selected
                        <?php } ?>
                        ><?= $municipio->nombre ?></option>
                    <?php } ?>
                </select>
                <label for="id_municipio">Municipio</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_sexo" id="id_sexo" value="<?= $persona->id_sexo ?>">
                    <?php if ((!$persona)) { ?>
                        <option value="" selected></option>
                    <?php } ?>
                    <?php foreach ($sexos as $sexo) { ?>
                        <option value=<?= $sexo->id ?>
                        <?php if (($sexo->id == $persona->id_sexo)) { ?>
                            selected
                        <?php } ?>
                        ><?= $sexo->nombre ?></option>
                    <?php } ?>
                </select>
                <label for="id_sexo">Sexo</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="rol" id="rol" value="<?= $persona->rol ?>">
                    <?php if ((!$persona)) { ?>
                        <option value="" selected></option>
                    <?php } ?>
                    <?php foreach ($roles as $rol) { ?>
                        <option value=<?= $rol ?>
                        <?php if (($rol == $persona->rol)) { ?>
                            selected
                        <?php } ?>
                        ><?= $rol ?></option>
                    <?php } ?>
                </select>
                <label for="rol">Rol</label>
            </div>
            <div class="form-floating">
                <input type="username" class="form-control" name="usuario" id="usuario" placeholder="Usuario" value="<?= $persona->usuario ?>" readonly />
                <label for="usuario">Usuario</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" name="clave" id="clave" placeholder="Clave">
                <label for="clave">Clave (mínimo 8 caracteres)</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" name="clave_confirmacion" id="clave_confirmacion" placeholder="Confirmar clave">
                <label for="clave">Confirmar Clave</label>
            </div>

            <input type="hidden" name="<?= $this->security->getTokenKey() ?>" value="<?= $this->security->getToken() ?>" />
            
            <div class="flex">
                <button class="w-100 btn btn-sm btn-success" type="submit">Guardar</button>
                <input type="button" class="w-100 btn btn-sm btn-danger" value="Eliminar" onclick="location.href='/persona/delete?id=<?= $persona->id ?>';" />
            </div>

        </form>
    </div>

    <div class="div_registros">
        <h3>Personas Encontradas en la Base de Datos</h3>
        <table class="table table-striped table-sm registros">
            <thead>
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Nombre Completo</th>
                <th scope="col">Tipo Documento</th>
                <th scope="col">Número Documento</th>
                <th scope="col">Municipio</th>
                <th scope="col">Sexo</th>
                <th scope="col">Usuario</th>
                <th scope="col">Rol</th>
                <th scope="col">Creación</th>
                <th scope="col">Modificación</th>
            </tr>
            <tbody>
                <?php foreach ($personasDTO as $personaDTO) { ?>
                <tr>
                    <td><a href="?id=<?= $personaDTO->id ?>"><?= $personaDTO->id ?></a></td>
                    <td><?= $personaDTO->nombre ?></td>
                    <td><?= $personaDTO->tipo_documento ?></td>
                    <td><?= $personaDTO->numero_documento ?></td>
                    <td><?= $personaDTO->municipio ?></td>
                    <td><?= $personaDTO->sexo ?></td>
                    <td><?= $personaDTO->usuario ?></td>
                    <td><?= $personaDTO->rol ?></td>
                    <td><?= $personaDTO->creacion ?></td>
                    <td><?= $personaDTO->modificacion ?></td>
                </tr>
                <?php } ?>
            </tbody>
            </thead>
        </table>
    </div>
    <input type="button" class="boton_impresion no-print" value="Exportar a Excel" onclick="exportarExcel();" />
</main>

<?= $this->flash->output() ?>



<footer class="footer mt-auto py-3 bg-light">
  <div class="container flex">
    <div class="text-muted">Secretaría Distrital de Cultura, Recreación y Deporte</div>
    <div class="text-muted">Usuario/a:<?= $this->session->get('nombre') ?>; Rol: <?= $this->session->get('rol') ?></div>
  </div>
</footer>

</body>
</html>