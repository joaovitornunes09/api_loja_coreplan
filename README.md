#### Back LojaCorePlan

##### Sobre tecnologias utilizadas nesse projeto:
- Ruby 3.2.0
- Rails 7.1.3
- Docker
- Docker Compose
- Postgres

## Informações

#### Funcionalidade
Este backend foi moldado para um sistema de admnistração de produtos de uma loja ficticia, sendo possivel criar, editar e excluir produtos e ofertas.

###### Administrador: 
Esse usuário será criado assim que você rodar o projeto nos passos de instalação, ele será capaz de realizar todas as operações dentro do sistema que conta com todo o tipo de manipulação referente aos produtos e ofertas.

- login: admin
- senha: admin123

###### Comum: 
O usuário comum, é aquele que poderá ser criado pelo proprio sistema de cadastro da aplicação, ele tera disponivel as operações padrão de visualizar produtos e criar pedidos abaixo segue as credenciais de um usuario que ja estará cadastrado quando você rodar o projeto.

- login: user
- senha: 112233


## Instalação

##### Requisito obrigátorios
Antes de tudo você precisa ter o docker e o docker-compose e também o git.
Caso não tenha instalado, aqui alguns links de referência:
- Aqui encontrar os passos para instalação do Docker => https://docs.docker.com/get-docker/ 
- Aqui encontrar os passos para instalação do Docker Compose => https://docs.docker.com/compose/ 
- Aqui encontrar os passos para instalação do git => https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

##### Clone o projeto
Com o git instalado e em um diretório da sua escolha, baixe o projeto:

```sh
git clone https://github.com/joaovitornunes09/api_loja_coreplan.git
```

##### Configuração de Arquivos:

1. Copiar o arquivo *docker-compose.example.yml* e colar com nome de *docker-compose.yml*
   
```sh
cp docker-compose.example.yml docker-compose.yml
```

##### Suba o serviço
Com o Docker-compose instalado, execute esse comando na raiz do projeto:

```sh
docker-compose up -d --build
```

Pronto agora a api está instalada.

Url: http://localhost:1005

#### Credenciais do banco

1. Host: 
```
localhost
```
2. Database: 
```
loja_coreplan
```
3. Username:
```
postgres
```
4. Password:
```
password
```
5. Port:
```
1004
```


