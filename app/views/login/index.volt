{# 
Autor: Santiago Hernández Plazas
Licencia: Creative Commons

Propósito de esta plantilla: mostrar vista del formulario de autenticación. 
#}

{% block head %}
    {{ this.assets.outputCss('estilos') }}
    {{ this.assets.outputCss('css-login') }}
{% endblock %}

{% block content %}

<main class="form-signin w-100 m-auto">
    <form action="{{ url('login/autenticar') }}" method="post">
        <h1 class="h3 mb-3 fw-normal">Por favor, autentíquese:</h1>

        <div class="form-floating">
            <input type="username" class="form-control" name="usuario" id="usuario" placeholder="Usuario">
            <label for="usuario">Usuario</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" name="clave" id="clave" placeholder="Clave">
            <label for="clave">Clave</label>
        </div>
        <input type="hidden" name="{{ security.getTokenKey() }}" value="{{ security.getToken() }}" />
        <button class="w-100 btn btn-lg btn-primary" type="submit">Ingresar</button>
    </form>
    {{ flash.output() }}
</main>

{% endblock %}