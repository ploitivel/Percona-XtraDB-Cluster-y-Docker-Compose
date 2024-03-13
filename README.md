# Cluster with Percona XtraDB Cluster and Docker Compose

This project makes it easy to deploy a cluster using Percona XtraDB Cluster with Docker Compose, enabling efficient configuration and management of distributed databases.

## Pre requirements

- Docker and Docker Compose installed on your system.
- Basic knowledge of Docker and MySQL database management.

## Initial setup

### Generation of SSL Certificates (IMPORTANT)

Before starting the cluster, it is crucial to generate your own SSL certificates for production environments. Use the following command to generate them with a temporary container:

```
mkdir -m 777 -p ~/pxc-docker-test/cert
docker run --name pxc-cert --rm -v ~/pxc-docker-test/cert:/cert percona/percona-xtradb-cluster:8.0 mysql_ssl_rsa_setup -d /cert
```
Verify that they exist and move them to the config/cert folder of this project
```
#verify
ls ~/pxc-docker-test/cert
#copy
cp -r ls ~/pxc-docker-test/cert/* BreadcrumbsPercona-XtraDB-Cluster-y-Docker-Compose/config/cert/
```

## Bootstrap container

The Bootstrap container, also known as the head node, plays a crucial role in cluster initialization. This node is responsible for booting the system, establishing the foundation for the other nodes to join the cluster sequentially.

### Bootstrap Container Build

To start the cluster, you first need to build the bootstrap container. Use the following command:
```
sudo docker compose build pxc-node1
```
### Start the Bootstrap Container

With the bootstrap container compiled, the next step is to start it:
```
sudo docker compose up pxc-node1 -d
```

## Secondary Nodes

Secondary nodes join the primary node to expand the cluster, running tasks and improving system performance and availability. They facilitate scalability and ensure effective resource management.

### Start All Nodes

Once the bootstrap node is up and running, you can start all the nodes in the cluster.
They will automatically connect to pxc-node1 without the Bootstrap node:
```
docker compose up -d
```
Congratulations, the cruster is running, check it with
```
docker ps 
```
### Add more Nodes

You can add more nodes by following the docker-compose-yml structure and following the structure of the configuration files of each node

### Database Access

To interact with the database, access any container and use the MySQL client:
```
sudo docker exec -it pxc-node1 /usr/bin/mysql -uroot -prootpassword
```
### Cluster Size Verification

To check the size and status of the cluster, run the following command in the MySQL client:
```
SHOW STATUS LIKE 'wsrep%';
```
### Additional Documentation and Resources

Percona Official Documentation
https://docs.percona.com/percona-xtradb-cluster/8.0/docker.html

# 🌌 It's time to light up the universe 🌌

Each donation is like adding a star in our universe of projects.

Can you help us light up the sky with more stars? Think of it as treating ourselves to a drink on an afternoon of brainstorming: refreshing, energizing and, oh, so necessary!

👉 [Be that star and shine with us here](https://donate.stripe.com/7sIbKicyugmgd6E289)

