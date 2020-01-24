#!/bin/bash

NOME_PACOTE="Node"

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

echo "Iniciando o download do ${NOME_PACOTE}"
if ! curl -sL https://deb.nodesource.com/setup_13.x | bash -; 
then
    echo "Não foi possivel fazer o download do ${NOME_PACOTE}"
    exit 1
fi
echo "Download do ${NOME_PACOTE} concluído"

echo "Instalando ${NOME_PACOTE}"
if ! apt-get install -y nodejs
then
    echo "Não foi possível instalar"
    exit 1
fi
echo "Instalação concluida."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
node --version

