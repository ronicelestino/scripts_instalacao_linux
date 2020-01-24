#!/bin/bash

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

echo "Criação do package.json"
if ! sudo npm init -y
then
    echo "Não foi criar o arquivo pakage.json"
    exit 1
fi
echo "Arquivo pakage.json criado com sucesso"


echo "Iniciando a instalação do Commitlint"
if ! sudo npm install --save-dev @commitlint/{config-conventional,cli}
then
    echo "Não foi possivel instalar o Commitlint"
    exit 1
fi
echo "Commitlint instalado com sucesso"


echo "Configurar commitlint para usar conventional config"
if ! sudo echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
then
    echo "Configurar o commitlint"
    exit 1
fi
echo "Commitlint configurado com sucesso"


echo "Iniciando a instalação do Husky"
if ! sudo npm install husky --save-dev
then
    echo "Não foi possível intalar o Husky"
    exit 1
fi
echo "Husky instalado com sucesso"

echo "Iniciando a instalação do Commitizen cli tools"
if ! npm install -g commitizen
then
    echo "Não foi possível intalar o Commitizen cli tools"
    exit 1
fi
echo "Commitizen cli tools instalado com sucesso"


echo "Inicializando projeto usando cz-conventional-changelog"
if ! commitizen init cz-conventional-changelog --save-dev --save-exact
then
    echo "Não foi possível iniciar o projeto cz-conventional-changelog "
    exit 1
fi
echo "Projetoinicializado com cz-conventional-changelog "


sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y


