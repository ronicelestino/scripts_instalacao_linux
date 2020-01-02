#!/bin/bash

if [ "$(whoami)" != "root" ]
then
    echo "Desculpe, você não é root. Use sudo!"
    exit 1
fi

echo "Atualizando repositórios.."
if ! apt-get update
then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
    echo "Atualização feita com sucesso"

echo "Atualizando pacotes já instalados"
if ! apt-get dist-upgrade -y
then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
    echo "Atualização de pacotes feita com sucesso"


echo "Download da versão atual do Visual Studio Code"
cd /tmp
if ! curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
then
    echo "Não foi possível Baixar o Visual Studio Code"
    exit 1
fi
    echo "Download do Visual Studio Code Conclúido"


echo "Adicionando as chaves do repositório"
if ! sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
then 
    echo "Erro ao aplicar chaves do repositório"
    exit 1
fi
    echo "Chaves do adicionadas com sucesso"


echo "Adicionando repositórios a sources.list"
if ! sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
then
    echo "Erro adicionar repositórios a sources.list"
    exit 1
fi 
    echo "Repositórios adicionados com sucesso!"


echo "Instalando Transport Https"
if ! sudo apt-get install apt-transport-https
then
    echo "Erro ao Instalando Transport Https"
    exit 1
fi
    echo "Transport Https instalado com sucesso!"

echo "Removendo arquivos de instalação"


if ! sudo apt-get update
then 
    echo "Atualizando repositorios"
    exit 1
fi
    echo "Erro ao atualiza os repositórios"

echo "Instalando Visual Studio Code"
if ! sudo apt-get install code # or code-insiders
then 
    echo "Erro ao instalar Visual Studio Code"
    exit 1
fi
    echo "Visual Studio Code Instalado com Sucesso"
