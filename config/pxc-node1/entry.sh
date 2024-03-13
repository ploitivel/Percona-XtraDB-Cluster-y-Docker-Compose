#!/bin/bash

# Ruta al archivo grastate.dat en el contenedor
GRSTATE_FILE="/var/lib/mysql/grastate.dat"

echo "Contenido antes de la modificación:"
cat "$GRSTATE_FILE"
sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/' "$GRSTATE_FILE"
echo "Contenido después de la modificación:"
cat "$GRSTATE_FILE"


# Pasa el control al entrypoint original de Percona con todos los argumentos pasados a este script
exec /entrypoint.sh "$@"