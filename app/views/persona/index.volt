{# 
Autor: Santiago Hernández Plazas
Licencia: Creative Commons

Propósito de esta plantilla: mostrar vista de administración de personas. 
#}

{% extends "templates/admin.volt" %}

{% block head %}
{% endblock %}

{% block content %}

<main class="form-admin w-100 m-auto">
    <div class="div_form">
        <form action="{{ url('persona/save') }}" method="post">
            <h1 class="h3 mb-3 fw-normal">Crear o editar persona:</h1>

            <div class="form-floating">
                <input type="number" class="form-control" name="id" id="id" placeholder="id" value="{{ persona.id }}" readonly />
                <label for="id">Identificador</label>
            </div>
            <div class="form-floating">
                <input type="text" class="form-control" name="nombre" id="nombre" placeholder="Nombre completo de documento" value="{{ persona.nombre }}" />
                <label for="nombre">Nombre Completo</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_tipo_documento" id="id_tipo_documento" value="{{ persona.id_tipo_documento }}">
                    {% if (!persona) %}
                        <option value="" selected></option>
                    {% endif %}
                    {% for tipoDocumento in tipos_documento %}
                        <option value={{ tipoDocumento.id }}>{{ tipoDocumento.nombre }}</option>
                    {% endfor %}
                </select>
                <label for="id_tipo_documento">Tipo de Documento</label>
            </div>
            <div class="form-floating">
                <input type="number" class="form-control" name="numero_documento" id="numero_documento" placeholder="Número de documento" value="{{ persona.numero_documento }}" />
                <label for="numero_documento">Número de Documento</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_departamento" id="id_departamento" value="" onchange="filtrarMunicipios(this.value);">
                    <option value="" selected></option>
                    {% for departamento in departamentos %}
                        <option value={{ departamento.id }}
                        >{{ departamento.nombre }}</option>
                    {% endfor %}
                </select>
                <label for="id_departamento">Departamento</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_municipio" id="id_municipio" value="{{ persona.id_municipio }}">
                    {% if (!persona) %}
                        <option value="" selected></option>
                    {% endif %}
                    {% for municipio in municipios %}
                        <option value={{ municipio.id }}
                        {% if (municipio.id == persona.id_municipio) %}
                            selected
                        {% endif %}
                        >{{ municipio.nombre }}</option>
                    {% endfor %}
                </select>
                <label for="id_municipio">Municipio</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="id_sexo" id="id_sexo" value="{{ persona.id_sexo }}">
                    {% if (!persona) %}
                        <option value="" selected></option>
                    {% endif %}
                    {% for sexo in sexos %}
                        <option value={{ sexo.id }}
                        {% if (sexo.id == persona.id_sexo) %}
                            selected
                        {% endif %}
                        >{{ sexo.nombre }}</option>
                    {% endfor %}
                </select>
                <label for="id_sexo">Sexo</label>
            </div>
            <div class="form-floating">
                <select class="form-control" name="rol" id="rol" value="{{ persona.rol }}">
                    {% if (!persona) %}
                        <option value="" selected></option>
                    {% endif %}
                    {% for rol in roles %}
                        <option value={{ rol }}
                        {% if (rol == persona.rol) %}
                            selected
                        {% endif %}
                        >{{ rol }}</option>
                    {% endfor %}
                </select>
                <label for="rol">Rol</label>
            </div>
            <div class="form-floating">
                <input type="username" class="form-control" name="usuario" id="usuario" placeholder="Usuario" value="{{ persona.usuario }}" readonly />
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

            <input type="hidden" name="{{ security.getTokenKey() }}" value="{{ security.getToken() }}" />
            
            <div class="flex">
                <button class="w-100 btn btn-sm btn-success" type="submit">Guardar</button>
                <input type="button" class="w-100 btn btn-sm btn-danger" value="Eliminar" onclick="location.href='/persona/delete?id={{ persona.id }}';" />
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
                {% for personaDTO in personasDTO %}
                <tr>
                    <td><a href="?id={{ personaDTO.id }}">{{ personaDTO.id }}</a></td>
                    <td>{{ personaDTO.nombre }}</td>
                    <td>{{ personaDTO.tipo_documento }}</td>
                    <td>{{ personaDTO.numero_documento }}</td>
                    <td>{{ personaDTO.municipio }}</td>
                    <td>{{ personaDTO.sexo }}</td>
                    <td>{{ personaDTO.usuario }}</td>
                    <td>{{ personaDTO.rol }}</td>
                    <td>{{ personaDTO.creacion }}</td>
                    <td>{{ personaDTO.modificacion }}</td>
                </tr>
                {% endfor %}
            </tbody>
            </thead>
        </table>
    </div>
    <input type="button" class="boton_impresion no-print" value="Exportar a Excel" onclick="exportarExcel();" />
</main>

{{ flash.output() }}

{% endblock %}

{# <h2>Administración de Personas</h2>

<?php if (property_exists($single, 'id')): ?>
    <?= $single->id ?>
    <?= $single->nombre ?>
<?php endif; ?>

<hr />

<?php foreach($all as $persona): ?>
    <?= $persona->id ?>
    <?= $persona->nombre ?>
    <br/>
<?php endforeach; ?>

<?php echo $this->tag->form("persona/create"); ?>

    <p>
        <label for="nombre">Nombre Completo</label>
        <input
    </p>

    <!--
    <p>
        <label for="email">E-Mail</label>
        <?php echo $this->tag->textField("email"); ?>
    </p>
    -->

    <p>
        <?php echo $this->tag->submitButton("Register"); ?>
    </p>

</form> #}