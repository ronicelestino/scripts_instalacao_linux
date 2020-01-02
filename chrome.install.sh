#!/bin/bash

NOME_PACOTE="GOOGLE CHROME"
PACOTE="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

echo "Atualizando repositórios.."
if ! apt-get update; then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização dos repositórios concluída."

echo "Atualizando pacotes já instalados"
if ! apt-get dist-upgrade -y; then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes concluída."

echo "Iniciando o download do ${NOME_PACOTE}"
if ! wget ${PACOTE}; then
    echo "Não foi possivel fazer o download do ${NOME_PACOTE}"
    exit 1
fi
echo "Download do ${NOME_PACOTE} concluído"

if ! sudo apt install ./google-chrome-stable_current_amd64.deb -y; then
    echo "Não foi possível instalar o pacote ${NOME_PACOTE}"
    exit 1
fi
echo "Instalação do ${NOME_PACOTE} finalizada"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

echo "Removendo arquivo de instalação ${NOME_PACOTE}"
if ! rm -rf google-chrome-stable_current_amd64.deb; then
    echo "Não foi possivel remover arquivo de instalação."
    exit 1
fi
echo "Arquivo de instalação removido com sucesso."
