#!/bin/bash

NOME_PACOTE="Zsh"

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

echo "Iniciando a instalação do Zsh"
if ! sudo apt install zsh
then
    echo "Não foi possivel instalar o Zsh"
    exit 1
fi
zsh --version && echo "Zsh instalado com sucesso"

echo "Definindo o Zsh como shell padrão"
if ! sudo chsh -s $(which zsh)
then
    echo "Não definir o Zsh como shell padrão"
    exit 1
fi
echo "Instalação concluida."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
node --version

