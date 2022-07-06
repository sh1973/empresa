

<!doctype html>
<html lang="es" class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $this->tag->getTitle() ?></title>
  <?= $this->assets->outputCss('estilos') ?>
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
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a class="nav-link" href="<?= $this->url->get('login') ?>">Ingresar</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>


  

<?= $this->flash->output() ?>



<main class="flex-shrink-0">
  <div class="container">
    <h1>EmpresApp</h1>
    <p>Aplicación para la administración de recursos humanos en las empresas.</p>
  </div>
</main>



<footer class="footer mt-auto py-3 bg-light">
  <div class="container flex">
    <div class="text-muted">Secretaría Distrital de Cultura, Recreación y Deporte</div>
  </div>
</footer>

</body>
</html>