#!/bin/bash

NOME_PACOTE="DART"

echo "Atualizando repositórios.."
if ! sudo apt-get update; 
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização dos repositórios concluída."

echo "Atualizando pacotes já instalados"
if ! sudo apt-get dist-upgrade -y; 
then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes concluída."

echo "Adicionando chaves do repositório"
if ! wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; 
then
    echo "Não foi possivel adicionar as chaves"
    exit 1
fi
echo "Chaves adicionada."

echo "Iniciando o download do ${NOME_PACOTE}"
if ! wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list; 
then
    echo "Não foi possivel fazer o download do ${NOME_PACOTE}"
    exit 1
fi
echo "Download do ${NOME_PACOTE} concluído"

echo "Atualizando repositórios.."
if ! sudo apt-get update; 
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização dos repositórios concluída."

echo "Instalando ${NOME_PACOTE}"
if ! sudo apt-get install dart -y && export PATH="$PATH:/usr/lib/dart/bin"
then
    echo "Não foi possível instalar"
    exit 1
fi
echo "Instalação concluida."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

