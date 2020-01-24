#!/bin/bash

NOME_PACOTE="qBittorrent"
PACOTE="qbittorrent"

echo "Atualizando repositórios.."
if ! apt-get update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização dos repositórios concluída."

echo "Atualizando pacotes já instalados"
if ! apt-get dist-upgrade -y
then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes concluída."

echo "Iniciando a instalação dos ${NOME_PACOTE}" 
if ! sudo apt install ${PACOTE} -y
then
    echo "Não foi possivel installar os ${NOME_PACOTE}" 
    exit 1
fi
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
echo "Instalação dos ${NOME_PACOTE} concluído"



