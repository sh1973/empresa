a:5:{i:0;s:287:"

<!doctype html>
<html lang="es" class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $this->tag->getTitle() ?></title>
  <?= $this->assets->outputCss('estilos') ?>
  <?= $this->assets->outputJs('js') ?>
  ";s:4:"head";a:1:{i:0;a:4:{s:4:"type";i:357;s:5:"value";s:3:"
  ";s:4:"file";s:92:"/home/santiago/trabajo/clientes/Potenciales/SDCRD/empresapp/app/views/templates/publico.volt";s:4:"line";i:17;}}i:1;s:843:"
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
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a class="nav-link" href="<?= $this->url->get('login') ?>">Ingresar</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>


  

<?= $this->flash->output() ?>

";s:7:"content";a:1:{i:0;a:4:{s:4:"type";i:357;s:5:"value";s:1:"
";s:4:"file";s:92:"/home/santiago/trabajo/clientes/Potenciales/SDCRD/empresapp/app/views/templates/publico.volt";s:4:"line";i:164;}}i:2;s:204:"

<footer class="footer mt-auto py-3 bg-light">
  <div class="container flex">
    <div class="text-muted">Secretaría Distrital de Cultura, Recreación y Deporte</div>
  </div>
</footer>

</body>
</html>";}