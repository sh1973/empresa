/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
Propósito: desplegar tablero
*/

var filtrandoMunicipiosDepartamentos = false;
const filtrarMunicipiosDepartamentos = async () => {
  if (filtrandoMunicipiosDepartamentos) return;

  filtrandoMunicipiosDepartamentos = true;

  var departamentos = '';
  var i_departamento = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'departamentos') {
        if (this.checked) {
          if (i_departamento > 0) {
            departamentos += ',';
          }
          departamentos += this.value;
          i_departamento++;
        }
      }
  });
  console.log (departamentos);

  var s = document.getElementById('filtro_municipios');
  s.innerHTML = "";

  if (departamentos.length == 0) {
    s.innerHTML = "Debe seleccionar al menos un departamento para poder filtrar los municipios.";
    filtrandoMunicipiosDepartamentos = false;
    return;
  }

  var url = "/municipio/filtrarPorDepartamentos/" + departamentos;
  console.log(url);

  const respuesta = await fetch(url);
  const json = await respuesta.json();

  // console.log(json);

  if (json.length === 0) {
    // div_resultadosPersonas += "<div class='div_mensaje_no_hay_mas'>No se encontraron más obras que coincidan con los términos de búsqueda que especificó.</div>";
  }

  for (var t = 0; t < json.length; t++) {
    var r = json[t];
    s.innerHTML += "<br><input type='checkbox' name='municipios' value='" + r.id + "' unchecked onclick=' onclick='refrescarTablero()'  />" + r.nombre;
  }

  filtrandoMunicipiosDepartamentos = false;

  refrescarTablero();
};

function exportarExcel() {
  var tipos_documento = '';
  var i_tipos_documento = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'tipos_documento') {
        if (this.checked) {
          if (i_tipos_documento > 0) {
            tipos_documento += ',';
          }
          tipos_documento += this.value;
          i_tipos_documento++;
        }
      }
  });
  console.log (tipos_documento);

  var sexos = '';
  var i_sexos = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'sexos') {
        if (this.checked) {
          if (i_sexos > 0) {
            sexos += ',';
          }
          sexos += this.value;
          i_sexos++;
        }
      }
  });
  console.log (sexos);

  var departamentos = '';
  var i_departamento = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'departamentos') {
        if (this.checked) {
          if (i_departamento > 0) {
            departamentos += ',';
          }
          departamentos += this.value;
          i_departamento++;
        }
      }
  });
  console.log (departamentos);

  var municipios = '';
  var i_municipios = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'municipios') {
        if (this.checked) {
          if (i_municipios > 0) {
            municipios += ',';
          }
          municipios += this.value;
          i_municipios++;
        }
      }
  });
  console.log (municipios);

  var url = "/dashboard/exportarExcel/?tipos_documento=" + tipos_documento + "&sexos=" + sexos + "&departamentos=" + departamentos + "&municipios=" + municipios;
  location.href = url;

}

var refrescandoTablero = false;
const refrescarTablero = async () => {
  if (refrescandoTablero) return;

  refrescandoTablero = true;

  var tipos_documento = '';
  var i_tipos_documento = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'tipos_documento') {
        if (this.checked) {
          if (i_tipos_documento > 0) {
            tipos_documento += ',';
          }
          tipos_documento += this.value;
          i_tipos_documento++;
        }
      }
  });
  console.log (tipos_documento);

  var sexos = '';
  var i_sexos = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'sexos') {
        if (this.checked) {
          if (i_sexos > 0) {
            sexos += ',';
          }
          sexos += this.value;
          i_sexos++;
        }
      }
  });
  console.log (sexos);

  var departamentos = '';
  var i_departamento = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'departamentos') {
        if (this.checked) {
          if (i_departamento > 0) {
            departamentos += ',';
          }
          departamentos += this.value;
          i_departamento++;
        }
      }
  });
  console.log (departamentos);

  var municipios = '';
  var i_municipios = 0;
  $('input[type=checkbox]').each(function () {
      if (this.name == 'municipios') {
        if (this.checked) {
          if (i_municipios > 0) {
            municipios += ',';
          }
          municipios += this.value;
          i_municipios++;
        }
      }
  });
  console.log (municipios);

  var s = document.getElementById('div_registros');
  s.innerHTML = '';

  var url = "/dashboard/refrescarTablero/?tipos_documento=" + tipos_documento + "&sexos=" + sexos + "&departamentos=" + departamentos + "&municipios=" + municipios;
  console.log(url);

  const respuesta = await fetch(url);
  const json = await respuesta.json();

  // console.log(json);

  if (json.length === 0) {
    // div_resultados.innerHTML += "<div class='div_mensaje_no_hay_mas'>No se encontraron más obras que coincidan con los términos de búsqueda que especificó.</div>";
  }

  if (json.length == 3) { 
    var personasDTO = json[0];

    var sPersonas = "";
    sPersonas += '<h3>Personas Encontradas en la Base de Datos</h3>';
    sPersonas += '<table class="table table-striped table-sm registros>';
    sPersonas += '  <thead>';
    sPersonas += '    <tr>';
    sPersonas += '      <th scope="col"></th>';
    sPersonas += '      <th scope="col">ID</th>';
    sPersonas += '      <th scope="col">Nombre</th>';
    sPersonas += '      <th scope="col">Tipo Documento</th>';
    sPersonas += '      <th scope="col">Número Documento</th>';
    sPersonas += '      <th scope="col">Municipio</th>';
    sPersonas += '      <th scope="col">Sexo</th>';
    sPersonas += '      <th scope="col">Usuario</th>';
    sPersonas += '      <th scope="col">Rol</th>';
    sPersonas += '      <th scope="col">Creación</th>';
    sPersonas += '      <th scope="col">Modificación</th>';
    sPersonas += '    </tr>';
    sPersonas += '  </thead>';
    sPersonas += '  <tbody>';

    for (var p = 0; p < personasDTO.length; p++) {
      sPersonas += '  <tr>';
      sPersonas += '    <td>' + personasDTO[p].id + '</td>';
      sPersonas += '    <td>' + personasDTO[p].nombre + '</td>';
      sPersonas += '    <td>' + personasDTO[p].tipo_documento + '</td>';
      sPersonas += '    <td>' + personasDTO[p].numero_documento + '</td>';
      sPersonas += '    <td>' + personasDTO[p].municipio + '</td>';
      sPersonas += '    <td>' + personasDTO[p].sexo + '</td>';
      sPersonas += '    <td>' + personasDTO[p].usuario + '</td>';
      sPersonas += '    <td>' + personasDTO[p].rol + '</td>';
      if (personasDTO[p].creacion == null) personasDTO[p].creacion = '';
      sPersonas += '    <td>' + personasDTO[p].creacion + '</td>';
      if (personasDTO[p].modificacion == null) personasDTO[p].modificacion = '';
      sPersonas += '    <td>' + personasDTO[p].modificacion + '</td>';
      sPersonas += '  </tr>';
    }

    sPersonas += '  </tbody>';
    sPersonas += '  </thead>';
    sPersonas += '</table>';

    s.innerHTML = sPersonas;

    var conteoPersonasPorSexo = json[1];
    generarGraficoConteoPersonasPorSexo(conteoPersonasPorSexo);
    
    var conteoPersonasPorTipoDocumento = json[2];
    generarGraficoConteoPersonasPorTipoDocumento(conteoPersonasPorTipoDocumento);

  }

  refrescandoTablero = false;
};

var a2coloresVerdes = ["#a6c795", "#689e44"];
var a2colores = ["#ffb71b", "#ea1331"];
var a5colores = ["#ff0004", "#ff00f3", "#0026b2", "#02b200", "#ff8000"];
var a7colores = [
  "#ff0004",
  "#ee00ff",
  "#0019ff",
  "#00ffff",
  "#04ff00",
  "#fff700",
  "#ff6a00",
];

var chartWidth = 400;
var chartHeight = 450;
var fontSizeChart = 9;


function generarGraficoConteoPersonasPorSexo(datos) {
  
  google.charts.load('current', {'packages':['corechart'], callback: function () {
    draw();
    $(window).resize(draw);
  }});
  
  function draw() {
    var div = document.getElementById('graficoConteoPersonasPorSexo');

    // var contenedor = div.parentNode;
    // if (contenedor) {
    //   contenedor.style.display = 'block';
    //   contenedor.style.position = 'relative';
    //   contenedor.style.width = chartWidth + 'px';
    //   contenedor.style.height = chartHeight + 'px';
    // }

    var a = new Array();

    a.push(["Sexo", "Conteo"]);

    for (var i = 0; i < datos.length; i++) {
      a.push([
        datos[i]['nombre'],
        datos[i]['conteo'],
      ]);
    }

    if (datos.length > 0) {
      var data = google.visualization.arrayToDataTable(a);
      var view = new google.visualization.DataView(data);

      var options = {
        title: "Distribución del Sexo",
        width: chartWidth,
        height: chartHeight,
        chartArea: { top: 20, width: "80%", height: "90%" },
        is3D: true,
        isStacked: false,
        hAxis: {
          title: "Distribución del Sexo",
          minValue: 0,
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        vAxis: {
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        colors: a5colores,
        legend: {
          title: "Sexo",
          position: "right",
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        annotations: {
          textStyle: {
            fontName: "Arial",
            fontSize: fontSizeChart,
            bold: false,
            italic: false,
            color: "black",
            auraColor: "white",
            opacity: 0.8,
          },
        },
      };

      if (data) {
        if (div) {
          var chart = new google.visualization.PieChart(div);
          chart.draw(data, options);
        }
      }
    }
    else {
      div.innerHTML = "No se encontraron registros";
    }
  }
  

  
}

function generarGraficoConteoPersonasPorTipoDocumento(datos) {
  
  google.charts.load('current', {'packages':['corechart', 'bar'], callback: function () {
    draw();
    $(window).resize(draw);
  }});

  function draw() {
    var div = document.getElementById('graficoConteoPersonasPorTipoDocumento');

    // var contenedor = div.parentNode;
    // if (contenedor) {
    //   contenedor.style.display = 'block';
    //   contenedor.style.position = 'relative';
    //   contenedor.style.width = chartWidth + 'px';
    //   contenedor.style.height = chartHeight + 'px';
    // }

    var a = new Array();

    a.push(["Tipo de Documento", "Conteo"]);

    for (var i = 0; i < datos.length; i++) {
      a.push([
        datos[i]['nombre'],
        datos[i]['conteo'],
      ]);
    }

    if (datos.length > 0) {
      var data = google.visualization.arrayToDataTable(a);
      var view = new google.visualization.DataView(data);

      var options = {
        title: "Personas por Tipo de Documento",
        width: chartWidth,
        height: chartHeight,
        chartArea: { top: 20, width: "60%", height: "90%" },
        is3D: true,
        isStacked: false,
        hAxis: {
          title: "Personas por Tipo de Documento",
          minValue: 0,
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        vAxis: {
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        colors: a5colores,
        legend: {
          title: "Sexo",
          position: "right",
          textStyle: {
            fontSize: fontSizeChart,
          },
        },
        annotations: {
          textStyle: {
            fontName: "Arial",
            fontSize: fontSizeChart,
            bold: false,
            italic: false,
            color: "black",
            auraColor: "white",
            opacity: 0.8,
          },
        },
      };

      if (data) {
        if (div) {
          var chart = new google.visualization.BarChart(div);
          chart.draw(data, options);
        }
      }
    }
    else {
      div.innerHTML = "No se encontraron registros";
    }

  }
}

$( document ).ready(function() {
  console.log( "ready!" );
  refrescarTablero();
});