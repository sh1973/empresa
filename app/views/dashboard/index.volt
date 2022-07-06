{# 
Autor: Santiago Hernández Plazas
Licencia: Creative Commons

Propósito de esta plantilla: mostrar vista de tablero. 
#}

{% extends "templates/privado.volt" %}

{% block head %}
    {{ this.assets.outputCss('css-dashboard') }}
{% endblock %}

{% block content %}

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
      {% for tipoDocumento in tipos_documento %}
        <br/><input type="checkbox" name="tipos_documento" value="{{ tipoDocumento.id }}" unchecked  onclick="refrescarTablero()" />{{ tipoDocumento.nombre }}
      {% endfor %}
      </div>
      <br/>
      <br/>
      <span class="span_etiqueta">Sexos</span>
      <div id="filtro_sexos">
      {% for sexo in sexos %}
        <br/><input type="checkbox" name="sexos" value="{{ sexo.id }}" unchecked onclick="refrescarTablero()" />{{ sexo.nombre }}
      {% endfor %}
      </div>
      <br/>
      <br/>
      <span class="span_etiqueta">Departamentos</span>
      <div id="filtro_departamentos">
      {% for departamento in departamentos %}
        <br/><input type="checkbox" name="departamentos" value="{{ departamento.id }}" unchecked onclick="filtrarMunicipiosDepartamentos()" />{{ departamento.nombre }}
      {% endfor %}
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


{% endblock %}