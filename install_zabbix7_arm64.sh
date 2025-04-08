#!/bin/bash

set -e

ZBX_VERSION="7.0.0"
ZBX_DIR="zabbix-$ZBX_VERSION"

echo "[+] Atualizando pacotes e instalando dependências..."
apt update
apt install -y build-essential \
  default-libmysqlclient-dev \
  libsnmp-dev \
  libcurl4-openssl-dev \
  libxml2-dev \
  libpcre3-dev \
  libssh2-1-dev \
  pkg-config \
  libssl-dev \
  libevent-dev \
  fping \
  wget \
  tar

echo "[+] Baixando o código-fonte do Zabbix $ZBX_VERSION..."
cd /usr/src
wget https://cdn.zabbix.com/zabbix/sources/stable/7.0/$ZBX_DIR.tar.gz
tar -xzf $ZBX_DIR.tar.gz
cd $ZBX_DIR

echo "[+] Configurando build com suporte completo..."
./configure --enable-server --enable-agent --with-mysql --with-net-snmp --with-libcurl --with-ssh2 --with-openssl

echo "[+] Compilando..."
make -j$(nproc)

echo "[+] Instalando..."
make install

echo "[✓] Zabbix $ZBX_VERSION instalado com sucesso!"
echo "Binários em: /usr/local/sbin"
echo "Configurações em: /usr/local/etc"
