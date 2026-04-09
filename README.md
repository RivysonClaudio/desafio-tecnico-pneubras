# Como executar o projeto

Stack com **Docker Compose**: PostgreSQL, API (Spring Boot), front (React) e Nginx na porta 80. A API e o front são construídas a partir dos repositórios remotos definidos no `docker-compose.yml`.

## Repositórios

- API: [https://github.com/RivysonClaudio/desafio-pneubras-api](https://github.com/RivysonClaudio/desafio-pneubras-api)
- WEB: [https://github.com/RivysonClaudio/desafio-pneubras-web](https://github.com/RivysonClaudio/desafio-pneubras-web)

## Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/) e [Docker Compose](https://docs.docker.com/compose/)
- Internet na primeira execução (download do código e build das imagens)

## Passo a passo

### 1. Clonar o repositório e entrar na pasta

```bash
git clone <url-do-repositório>.git
cd desafio-tecnico-pneubras
```

### 2. Subir os serviços

```bash
docker compose up --build
```

Na primeira vez o build pode demorar alguns minutos.

### 3. Acessar no navegador

|           | URL                                                                              |
| --------- | -------------------------------------------------------------------------------- |
| Aplicação | [http://localhost](http://localhost)                                             |
| Swagger   | [http://localhost/swagger-ui/index.html](http://localhost/swagger-ui/index.html) |

### 4. Login inicial (admin)

Valores padrão no `docker-compose.yml`:

- **E-mail:** `admin.api@pneubras.com`
- **Senha:** `12345678`

### 5. Encerrar

```bash
docker compose down
```

Para apagar também os dados do banco:

```bash
docker compose down -v
```

## Observações

- Se a porta **80** estiver em uso, altere o mapeamento do serviço `nginx` no `docker-compose.yml` (por exemplo `"8080:80"`).
- Se mudar a senha do Postgres (`POSTGRES_PASSWORD`), ajuste também `DB_PASSWORD` da API no mesmo arquivo para o mesmo valor.
