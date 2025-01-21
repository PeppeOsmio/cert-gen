#!/bin/bash
set -ex
mkdir -p /output
if [ ! -f "/output/${CERTIFICATE_NAME}" ] || [ ! -f "/output/${PRIVATE_KEY_NAME}" ]; then
    # if those are directories remove them
    rm -rf "/output/${CERTIFICATE_NAME}"
    rm -rf "/output/${PRIVATE_KEY_NAME}"
    openssl req -x509 -nodes -days ${DURATION_DAYS} -newkey rsa:2048 -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}" \
    -keyout "/output/${PRIVATE_KEY_NAME}" -out "/output/${CERTIFICATE_NAME}"
fi
if [ -n "${DHPARAM_NAME}" ] && [ ! -f "/output/${DHPARAM_NAME}" ]; then
    # if this is a directory remove it
    rm -rf "/output/${DHPARAM_NAME}"
    openssl dhparam -out /output/${DHPARAM_NAME} 2048
fi

if [ -n "${CHMOD_PERMISSIONS}" ]; then
    chmod -R "${CHMOD_PERMISSIONS}" "/output"
fi

if [ -n "${CHOWN_OWNERS}" ]; then
    chown -R "${CHOWN_OWNERS}" "/output"
fi