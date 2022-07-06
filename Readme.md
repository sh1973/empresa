Aplicativo EmpresApp

Requisitos:
Sistema operativo: linux (no se probó en otros SO)
> Phalcon 4.1.2 (se incluye en la carpeta, si no cuenta o no desea tener  configuración global por web server)
> PHP 7.2
> git (para poder clonar)
> PostgreSQL >= 10

Como instalar el aplicativo (instrucciones para linux):

1. Ingresar a una carpeta a la que tenga permisos de escritura
2. Clonar el proyecto:
git clone https://github.com/sh1973/empresa.git
(El proyecto será clonado por defecto en la carpeta empresa)


Cómo preparar la Base de Datos:
dentro de la carpeta empresa se encuentra el backup de la base de datos en la subcarpeta bd:
bd/empresa.backup
Puede usar dbeaver para importar la bae de datos.
Otra opciones para restaurar la base de datos:
pg_restore -U postgres -d empresa -1 empresa.backup

> La restauración deberá crear la base de datos
Si por alguna razón esta no es creada puede usar la siguiente consulta psql para crearla:
create database empresa encoding 'UTF8';

> Crear usuario y Otorgar los privilegios:
create user empresauser with password 'empresauser';
alter role empresauser with login;
GRANT USAGE ON SCHEMA public TO empresauser;
grant all privileges on database empresa to empresauser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO empresauser;
GRANT ALL PRIVILEGES ON ALL sequences IN SCHEMA public TO empresauser;
GRANT ALL PRIVILEGES ON ALL functions IN SCHEMA public TO empresauser;


Cómo configurar el aplicativo:
1. Ingresar a la carpeta empresa
cd <ruta-aplicativo>/empresa

2. Edite el archivo de código fuente empresa/public/index.php con su editor favorito:

Busque la línea 114 y reemplace:
  $parametrosBD = [
    'host' => '192.168.1.60',
    'username' => 'empresauser',
    'password' => 'empresauser',
    'dbname' => 'empresa',
    'schema' => 'public'
  ];
  
... Por los parámetros de conexión (IP) y autenticación de su servidor de PostgreSQL si prefiere usar el usuario Postgres.

Cómo iniciar el aplicativo con servicio de phantom
1. Ingresar a la carpeta empresa
cd <ruta-aplicativo>/empresa

2. Iniciar el aplicativo
./phantom server
(Nota: si está en windows, use la ruta vendor\bin\phantom server ya que en windows no se manejan enlaces simbólicos con facilidad)

Debería visualizar las siguientes líneas:
./phalcon server

Phalcon DevTools (4.2.0)

Preparing Development Server
  Host: 0.0.0.0
  Port: 8000
  Base: .htrouter.php
  Document Root: public
Starting Server with /usr/bin/php7.2 -S 0.0.0.0:8000 -t .htrouter.php -t public 

Nota: es posible que el servicio de phalcon le pregunte si desea crear carpetas para poder ejecutarse, dígale que sí.

Como comprobar que está funcionando el aplicativo:
Abrir en alguno de los navegadores más populares (Chrome, Firefox, Brave) el aplicativo en la siguiente URL:

http://localhost:8000

Debería entonces aparecerle la aplicación en su navegador.

Por favor ver los videos tutoriales para capacitarse en el uso de la aplicación demostracion.mp4 que se encuentran en la carpeta "empresa/documentacion" del proyecto.

Para realizar las pruebas del API de REST desde Postman se grabó la colección en la sucarpeta ColeccionPostman y el nombre del archivo es PruebasEmpresApp.postman_collection.json.  Por favor al realizar las pruebas con los llamados REST de la colección, usar el id de la persona que se creó en la base de datos.  De lo contrario no funcionarán varias de las pruebas.

Cordialmente,

Santiago Hernández
