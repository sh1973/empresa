{# 
Autor: Santiago Hernández Plazas
Licencia: Creative Commons

Propósito de esta plantilla: mostrar vista de cierre de sesión. 
#}

{% extends "templates/publico.volt" %}

{% block head %}
    {{ this.assets.outputCss('estilos') }}
    {{ this.assets.outputCss('css-login') }}
{% endblock %}

{% block content %}

<main class="form-signin w-100 m-auto">
  {{ flash.output() }}
  <h3>Gracias por usar esta aplicación</h3>
</main>

{% endblock %}