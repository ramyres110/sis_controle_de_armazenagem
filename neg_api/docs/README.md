# API de Contratos Sistema de Controle de Armazenagem de Grãos
- Autor: Ramyres Aquino, [ramyres110](https://github.com/ramyres110)
- Dt: 29/05/2020

## Instalação
Ver arquivo `INSTALL.md`

## Scripts
Em desenvolvimento, temos os scripts para auxilio, para executar `npm run <comando>`, comandos:
- **start** : Executa a aplicação em produção (Antes executar build)
- **dev** : Executa a aplicação em desenvolvimento
- **test** : Executa todos os teste
- **test-watch** : Executa os testes e fica observando alterações para executar novamente.
- **build** : Executa a validação e constroi a aplicação
- **webpack** : Constroi o compactado da aplicação
- **lint** : Valida o código da aplicação

## Rotas

### Contratos

#### Listar todos os Contratos
```http
GET /api/v1/contratos HTTP/1.1
```

#### Requisitar um contrato pelo ID
```http
GET /api/v1/contratos/{{uid}} HTTP/1.1
```

#### Requisitar um contrato pelo documento do produtor
```http
GET /api/v1/contratos/produtor/{{document}} HTTP/1.1
```

#### Salvar um Contrato
```http
POST /api/v1/contrato HTTP/1.1
Content-Type: application/json

{{Contrato.json}}
```

#### Valida um Contrato
```http
POST /api/v1/contrato/{{uid}}/valida HTTP/1.1
Content-Type: application/json

{
    "isValidated": true,
    "validatedBy": "Validante do Contrato"
}
```

#### Altera um Contrato
```http
PUT /api/v1/contrato/{{uid}} HTTP/1.1
Content-Type: application/json

{{Contrato.json}}
```

#### Exclui um Contrato
```http
DELETE /api/v1/contrato/{{uid}} HTTP/1.1
```


### Exemplo
```json

```
