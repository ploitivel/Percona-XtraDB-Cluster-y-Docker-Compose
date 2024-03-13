FROM percona/percona-xtradb-cluster:8.0

COPY entry.sh /

# Asegúrate de que el script sea ejecutable desde el host
#RUN chmod +x /entrypoint_personalizado.sh

# Establece tu script como el punto de entrada
ENTRYPOINT ["/entry.sh"]

# Expone los puertos necesarios para MySQL y Galera Cluster
EXPOSE 3306 33060 4567 4568

# Especifica el comando por defecto para el contenedor
CMD ["mysqld"]
