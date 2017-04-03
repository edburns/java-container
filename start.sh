#!/bin/bash

echo "================================================================================"
echo "Starting Java Service..."
echo "================================================================================"

if [ ! -z "${MM_GID}" ]; then
    echo "Linux group id: ${MM_GID}"
fi

if [ ! -z "${MM_UID}" ]; then
    echo "Linux user id: ${MM_UID}"
fi

EXEC_LINE="java -XX:+PrintFlagsFinal -XX:+PrintGCDetails ${JAVA_OPTIONS} -jar java-container.jar"

if [ ! -z "${MM_UID}" ]; then
    echo "================================================================================"
    echo "Executing su -c exec \"${EXEC_LINE}\" mm"
    echo "================================================================================"
    groupadd --gid ${MM_GID} mm
    useradd --uid ${MM_UID} --gid ${MM_GID} --create-home --home /home/mm mm
    chown mm /home/mm
    chown -R mm /persistence
    exec su -c "${EXEC_LINE}" mm
else
    echo "================================================================================"
    echo "Executing ${EXEC_LINE}"
    echo "================================================================================"
    exec ${EXEC_LINE}
fi
