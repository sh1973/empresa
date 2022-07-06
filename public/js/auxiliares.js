/*
Autor: Santiago Hernández Plazas
Licencia: Creative Commons
*/

/*
La siguiente funcion filtrarMunicipios es un ejemplo de uso de ajax para
consumir servicios REST en phalcon.

Se podrían implementar métodos similares a este para usar el 
CRUD de cualquier tabla por REST api.

*/

var filtrandoMunicipios = false;
const filtrarMunicipios = async (id_departamento) => {
  if (filtrandoMunicipios) return;

  filtrandoMunicipios = true;

  var s = document.getElementById('id_municipio');

  var url = "/municipio/filtrar/" + id_departamento;
  console.log(url);

  const respuesta = await fetch(url);
  const json = await respuesta.json();

  // console.log(json);

  if (json.length === 0) {
    // div_resultados.innerHTML += "<div class='div_mensaje_no_hay_mas'>No se encontraron más obras que coincidan con los términos de búsqueda que especificó.</div>";
  }

  s.options.length = 1;
  s.options[0].value = "";
  s.options[0].text = "";

  for (var t = 0; t < json.length; t++) {
    var r = json[t];
    // console.log(r.nombre);
    s.options.length = s.options.length + 1;
    s.options[s.options.length - 1].value = r.id;
    s.options[s.options.length - 1].text = r.nombre;
  }

  filtrandoMunicipios = false;
};


function exportarExcel() {
  var url = "/persona/exportarExcel";
  location.href = url;
}


