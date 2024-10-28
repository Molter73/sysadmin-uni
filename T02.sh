#!/usr/bin/env bash

set -euxo pipefail

ADMIN_DIR="${HOME}/admin_sistema"

# Crear estructura de archivos
mkdir -p "${ADMIN_DIR}"/{procesos,memoria,logs,disco}
tree "${ADMIN_DIR}"

# Crear archivo de log
LOG_FILE="${ADMIN_DIR}/logs/registro.log"
echo "$(date): Creada estructura de directorios en ~/admin_sistema" > "${LOG_FILE}"

# Procesos en ejecución
ps aux > "${ADMIN_DIR}/procesos/todos.txt"
ps aux | grep root > "${ADMIN_DIR}/procesos/root.txt"

echo "$(date): Creada captura de procesos en ejecución" >> "${LOG_FILE}"

# Memoria disponible
free -h > "${ADMIN_DIR}/memoria/libre.txt"

echo "$(date): Creada captura de memoria disponible" >> "${LOG_FILE}"

# Utilización de disco
df -h > "${ADMIN_DIR}/disco/uso.txt"

echo "$(date): Creada captura de uso de disco" >> "${LOG_FILE}"

# Contar procesos de root
grep -E "^root" "${ADMIN_DIR}/procesos/todos.txt" | wc -l > "${ADMIN_DIR}/procesos/root-count.txt"

echo "$(date): Contados procesos de root" >> "${LOG_FILE}"

# Contar líneas de captura de memoria
wc -l "${ADMIN_DIR}/memoria/libre.txt" > "${ADMIN_DIR}/memoria/lineas.txt"

echo "$(date): Contadas líneas en fichero de memoria" >> "${LOG_FILE}"

# Configurar permisos de archivos
find "${ADMIN_DIR}" -type f -exec chmod 0644 '{}' \;

echo "$(date): Cambiados permisos de ficheros" >> "${LOG_FILE}"

# Configurar nuevo usuario y ACL
sudo useradd usuario1

echo "$(date): Creado usuario usuario1" >> "${LOG_FILE}"

setfacl -m u:usuario1:r "${ADMIN_DIR}/memoria"
setfacl -m u:usuario1:000 "${ADMIN_DIR}/procesos"
setfacl -m u:usuario1:000 "${ADMIN_DIR}/disco"

echo "$(date): Creadas ACL para usuario1" >> "${LOG_FILE}"
