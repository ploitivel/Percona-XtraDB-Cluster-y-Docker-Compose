
# Cluster con Percona XtraDB Cluster y Docker Compose

Este proyecto facilita la implementación de un clúster utilizando Percona XtraDB Cluster con Docker Compose, lo que permite una configuración y gestión eficiente de bases de datos distribuidas.

## Pre-requisitos

- Docker y Docker Compose instalados en tu sistema.
- Conocimientos básicos de Docker y gestión de bases de datos MySQL.

## Configuración Inicial

### Generación de Certificados SSL (IMPORTANTE)

Antes de iniciar el clúster, es crucial generar tus propios certificados SSL para entornos de producción. Utiliza el siguiente comando para generarlos con un contenedor temporal:

mkdir -m 777 -p ~/pxc-docker-test/cert
docker run --name pxc-cert --rm -v ~/pxc-docker-test/cert:/cert percona/percona-xtradb-cluster:8.0 mysql_ssl_rsa_setup -d /cert

Verifica que existan y muevelos a la carpeta config/cert de este proyecto
ls ~/pxc-docker-test/cert

### Compilación del Contenedor Bootstrap

Para iniciar el clúster, primero necesitas compilar el contenedor bootstrap. Utiliza el siguiente comando:

sudo docker compose build pxc-node1

### Iniciar el Contenedor de Bootstrap

Con el contenedor bootstrap compilado, el siguiente paso es iniciarlo:

sudo docker compose up pxc-node1 -d

### Iniciar Todos los Nodos

Una vez el nodo bootstrap está en funcionamiento, puedes iniciar todos los nodos del clúster. 
Se conectarán automáticamente a pxc-node1:

docker compose up -d

### Acceso a la Base de Datos

Para interactuar con la base de datos, accede a cualquier contenedor y utiliza el cliente MySQL:

sudo docker exec -it pxc-node1 /usr/bin/mysql -uroot -prootpassword

### Verificación del Tamaño del Clúster

Para verificar el tamaño y estado del clúster, ejecuta el siguiente comando en el cliente MySQL:

SHOW STATUS LIKE 'wsrep%';

### Documentación y Recursos Adicionales

Mas informacion Documentacion Offcial de percona 
https://docs.percona.com/percona-xtradb-cluster/8.0/docker.html