{# 
Autor: Santiago Hernández Plazas
Licencia: Creative Commons

Propósito de esta plantilla: plantilla abstracta de consulta. 
#}

<!doctype html>
<html lang="es" class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ get_title() }}</title>
  {{ this.assets.outputCss('estilos') }}
  {{ this.assets.outputJs('js') }}
  {% block head %}
  {% endblock %}
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
          <li><a class="nav-link" href="{{ url('logout') }}">Salir</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>

{{ flash.output() }}

{% block content %}
{% endblock %}

<footer class="footer mt-auto py-3 bg-light">
  <div class="container flex">
    <div class="text-muted">Secretaría Distrital de Cultura, Recreación y Deporte</div>
    <div class="text-muted">Usuario/a:{{ this.session.get('nombre') }}; Rol: {{ this.session.get('rol') }}</div>
  </div>
</footer>

</body>
</html>