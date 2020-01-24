echo "Atualizando repositórios.."
if ! apt-get update; then
    echo "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list"
    exit 1
fi
echo "Atualização feita com sucesso"

echo "Atualizando pacotes já instalados"
if ! apt-get dist-upgrade -y; then
    echo "Não foi possível atualizar pacotes."
    exit 1
fi
echo "Atualização de pacotes feita com sucesso"

echo "INSTALANDO DEPENDÊNCIAS"
if ! sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common -y; then
    echo "Não foi possível instalar todas as dependências"
    exit 1
fi
echo "Dependências instaladas com sucesso."

echo "ADICIONANDO  Docker’s official GPG key"
if ! curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -; then
    echo "Erro ao adicionar  Docker’s official GPG key"
    exit 1
fi
echo "Docker’s official GPG key adicionado com sucesso."

echo "Configurando repositório estável do Docker CE"
if ! sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"; then
    echo "Não foi possível configurar o repositório"
    exit 1
fi
echo "Repositório adicionado com sucesso."

echo "INSTALANDO Docker Engine CE"
sudo apt update
if ! sudo apt-get install docker-ce docker-ce-cli containerd.io -y; then
    echo "Não foi possível instalar ocker Engine - CE."
    exit 1
fi
echo "Docker Engine - CE instalado com sucesso."

echo "Criando Grupo Dockear"
if ! sudo groupadd docker; then
    echo "Erro ou grupo já existente"
fi
echo "Grupo docker criado com sucesso"

echo "Adicione seu usuário ao grupo Docker"
if ! sudo usermod -aG docker $USER; then
    echo "Não foi possível adicionar seu usuário ao grupo Docker"
fi
echo "Usuário adicionado ao grupo Docker"

echo "Download da versão estável atual do Docker Compose"
if ! sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; then
    echo "Não foi possível Baixar o Dcoker Compose"
    exit 1
fi
echo "Download do Docker Compose Conclúido"

echo "Aplicando permissões executáveis ​​ao binário"
if ! sudo chmod +x /usr/local/bin/docker-compose; then
    echo "Erro ao aplicar permissões ao binário"
    exit 1
fi
echo "Permissões aplicadas com sucesso"

docker-compose --version
