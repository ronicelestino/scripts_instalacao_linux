#!/bin/bash

NOME_PACOTE="SMPLAYER"
LINK="https://download.opensuse.org/repositories/home:/smplayerdev/Debian_10/amd64/smplayer_19.10.2+2.2_amd64.deb"
PACOTE="smplayer_19.10.2+2.2_amd64.deb"

echo "Atualizando repositórios.."
if ! apt-get update; 
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização dos repositórios concluída."

echo "Atualizando pacotes já instalados"
if ! apt-get dist-upgrade -y; 
then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes concluída."

echo "Iniciando o download do ${NOME_PACOTE}"
if ! wget ${LINK}; 
then
    echo "Não foi possivel fazer o download do ${NOME_PACOTE}"
    exit 1
fi
echo "Download do ${NOME_PACOTE} concluído"

echo "Iniciando o download do ${NOME_PACOTE}"
if ! wget ${LINK}; 
then
    echo "Não foi possivel fazer o download do ${NOME_PACOTE}"
    exit 1
fi
echo "Download do ${NOME_PACOTE} concluído"

if ! sudo apt install ./${PACOTE} -y; 
then
    echo "Não foi possível instalar o pacote ${NOME_PACOTE}"
    exit 1
fi
echo "Instalação do ${NOME_PACOTE} finalizada"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

echo "Removendo arquivo de instalação ${NOME_PACOTE}"
if ! rm -rf ${PACOTE}; 
then
    echo "Não foi possivel remover arquivo de instalação."
    exit 1
fi
echo "Arquivo de instalação removido com sucesso."
