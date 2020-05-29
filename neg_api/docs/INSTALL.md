# Manual de Instalação
- Autor: Ramyres Aquino, [ramyres110](https://github.com/ramyres110)
- Dt: 29/05/2020

## Pré Requisitos
- Node v10.16 ou superior
- NPM  v6.9.0 ou superior
- Firebird 2.1

## Configuração
- Pode ser configurado pelas variáveis de ambiente ou
- configurado por um arquivo .env na pasta raiz do projeto, arquivo .env
```ini
# ENVIRONMENT
PORT=
# DATABASE
FB_USER=
FB_PASS=
FB_HOST=
FB_PORT=
FB_DATABASE=
```

## Execução
1. Em um terminal,
1. Instale as dependências executando o comando `npm install` na raiz do projeto (onde contém o _package.json_)
1. Executar comando de construção: `npm run build`
1. Para executar em produção, execute: `npm start`
1. Para executar em desenvolvimento, execute: `npm run dev`
1. Para deploy é necessário apenas a pasta `bin` e a `data`
1. 

