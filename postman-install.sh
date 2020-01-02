#!bin/bash

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


echo "Download da versão estável atual do Postman"
cd /tmp
if ! wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
then
    echo "Não foi possível Baixar o Dcoker Compose"
    exit 1
fi
    echo "Download do Postman Conclúido"


echo "Aplicando permissões executáveis ​​ao binário"
if ! sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
then 
    echo "Erro ao aplicar permissões ao binário"
    exit 1
fi
    echo "Permissões aplicadas com sucesso"

echo "Criando link simbólico"
if ! sudo ln -s /opt/Postman/Postman /usr/bin/postman
then
    echo "Erro ao criar link simbólico"
    exit 1
fi 
    echo "link simbólico criado com sucesso"

echo "Criando atalho"
if ! cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL

then
    echo "Erro ao criar atalho"
    exit 1
fi
    echo "Atalho criado com sucesso"

echo "Removendo arquivos de instalação"
if ! rm -Rf postman.tar.gz
then 
    echo "Erro ao apagar arquivo"
    exit 1
fi
    echo "Arquivo apagado com sucesso"