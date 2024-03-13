
# Cluster con Percona XtraDB Cluster y Docker Compose

Este proyecto facilita la implementación de un clúster utilizando Percona XtraDB Cluster con Docker Compose, lo que permite una configuración y gestión eficiente de bases de datos distribuidas.

## Pre-requisitos

- Docker y Docker Compose instalados en tu sistema.
- Conocimientos básicos de Docker y gestión de bases de datos MySQL.

## Configuración Inicial

### Generación de Certificados SSL (IMPORTANTE)

Antes de iniciar el clúster, es crucial generar tus propios certificados SSL para entornos de producción. Utiliza el siguiente comando para generarlos con un contenedor temporal:

```
mkdir -m 777 -p ~/pxc-docker-test/cert
docker run --name pxc-cert --rm -v ~/pxc-docker-test/cert:/cert percona/percona-xtradb-cluster:8.0 mysql_ssl_rsa_setup -d /cert
```
Verifica que existan y muevelos a la carpeta config/cert de este proyecto
```
#verfica que se ayan generado
ls ~/pxc-docker-test/cert
#copialos al proyecto
cp -r ls ~/pxc-docker-test/cert/ BreadcrumbsPercona-XtraDB-Cluster-y-Docker-Compose/config/cert/
```

## Contenedor Bootstrap

El contenedor de Bootstrap, también conocido como el nodo principal, juega un papel crucial en la inicialización del clúster. Este nodo es responsable de arrancar el sistema, estableciendo las bases para que los demás nodos se integren al clúster de manera secuencial.

### Compilación del Contenedor Bootstrap

Para iniciar el clúster, primero necesitas compilar el contenedor bootstrap. Utiliza el siguiente comando:
```
sudo docker compose build pxc-node1
```
### Iniciar el Contenedor de Bootstrap

Con el contenedor bootstrap compilado, el siguiente paso es iniciarlo:
```
sudo docker compose up pxc-node1 -d
```

## Nodos Secundarios

Los nodos secundarios se unen al nodo principal para expandir el clúster, ejecutando tareas y mejorando el rendimiento y la disponibilidad del sistema. Facilitan la escalabilidad y aseguran una gestión eficaz de recursos.

### Iniciar Todos los Nodos

Una vez el nodo bootstrap está en funcionamiento, puedes iniciar todos los nodos del clúster. 
Se conectarán automáticamente a pxc-node1 sindo el nodo Bootstrap:
```
docker compose up -d
```
Felicidades el cruster esta corriendo verificalo con 
```
docker ps 
```
### Agregar mas Nodos

Puedes agregar mas nodos siguiendo la estructura del docker-compose-yml y siguiedo la estructura de los archivos de configuracion de cada nodo

### Acceso a la Base de Datos

Para interactuar con la base de datos, accede a cualquier contenedor y utiliza el cliente MySQL:
```
sudo docker exec -it pxc-node1 /usr/bin/mysql -uroot -prootpassword
```
### Verificación del Tamaño del Clúster

Para verificar el tamaño y estado del clúster, ejecuta el siguiente comando en el cliente MySQL:
```
SHOW STATUS LIKE 'wsrep%';
```
### Documentación y Recursos Adicionales

Documentacion Official de percona 
https://docs.percona.com/percona-xtradb-cluster/8.0/docker.html

# 🌌 Es hora de iluminar el universo 🌌

Cada donación es como agregar una estrella en nuestro universo de proyectos.

¿Nos ayudas a iluminar el cielo con más estrellas? Piensa en ello como invitarnos a un refresco en una tarde de brainstorming: refrescante, energizante y, oh, ¡tan necesario!

👉 [Sé esa estrella y brilla con nosotros aquí](https://donate.stripe.com/7sIbKicyugmgd6E289](https://donate.stripe.com/7sIbKicyugmgd6E289)

