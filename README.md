# Desafio técnico Pneubras — API + Web + PostgreSQL + Nginx

Stack completa orquestrada pelo **Docker Compose**: **PostgreSQL**, **API** (Spring Boot), **front** (React/Vite) e **Nginx** como proxy reverso na porta 80.

Os serviços **api** e **web** são **construídos a partir do código no GitHub** (contexto remoto no `docker-compose.yml`), não a partir de pastas locais do projeto. Neste repositório ficam principalmente o Compose, a config do Nginx e scripts auxiliares.

| Repositório                                                                    | Papel                      |
| ------------------------------------------------------------------------------ | -------------------------- |
| [desafio-pneubras-api](https://github.com/RivysonClaudio/desafio-pneubras-api) | Backend Java / Spring Boot |
| [desafio-pneubras-web](https://github.com/RivysonClaudio/desafio-pneubras-web) | Frontend React / Vite      |

---

## O que você precisa

- [Docker](https://docs.docker.com/get-docker/) e [Docker Compose](https://docs.docker.com/compose/) com **BuildKit** habilitado (padrão nas versões recentes; necessário para `build` com URL Git)
- Acesso à internet na primeira `docker compose build` / `up --build` (clone temporário dos repositórios)

---

## Como rodar (Docker Compose)

### 1. Clonar este repositório e entrar na pasta

```bash
git clone <url-deste-repo>.git
cd desafio-tecnico-pneubras
```

Confirme na raiz: `docker-compose.yml` e `default.conf` (Nginx montado no serviço `nginx`).

### 2. Subir os serviços

```bash
docker compose up --build
```

Na **primeira** execução o Docker baixa o contexto Git dos repositórios da API e do Web e roda o build das imagens (pode levar alguns minutos). Depois, o Compose:

1. Sobe o **PostgreSQL** e aguarda o healthcheck.
2. Constrói e sobe a **API** a partir de `https://github.com/RivysonClaudio/desafio-pneubras-api.git` (porta 8080 só na rede interna).
3. Constrói e sobe o **Web** a partir de `https://github.com/RivysonClaudio/desafio-pneubras-web.git`, com `VITE_API_URL=/api/v1` para o proxy.
4. Sobe o **Nginx** na porta **80** do host, encaminhando `/` para o front e `/api/` para a API.

### 3. Acessar a aplicação

| O quê           | URL                                                                  |
| --------------- | -------------------------------------------------------------------- |
| Frontend        | [http://localhost](http://localhost)                                 |
| API (via proxy) | [http://localhost/api/v1/...](http://localhost/api/v1/)              |
| Swagger UI      | [http://localhost/swagger-ui.html](http://localhost/swagger-ui.html) |

### 4. Credenciais padrão (compose)

Definidas no `docker-compose.yml` para o bootstrap da API:

- **E-mail:** `admin.api@pneubras.com`
- **Senha:** `12345678`

O primeiro start da API cria esse usuário **ADMIN** se ainda não existir no banco.

### 5. Parar e limpar

```bash
docker compose down
```

Para apagar também o volume do Postgres (dados do banco):

```bash
docker compose down -v
```

### Variáveis úteis

- `POSTGRES_PASSWORD` — senha do Postgres (padrão `postgres` se não definida). **Observação:** no `docker-compose.yml` o serviço `api` usa `DB_PASSWORD: postgres` fixo; se você mudar a senha do Postgres, alinhe também a variável de ambiente da API para o mesmo valor.
- Se a porta 80 estiver ocupada, altere o mapeamento de portas do serviço `nginx` no `docker-compose.yml` (por exemplo `"8080:80"`).

---

## O que há neste repositório

| Arquivo / pasta                        | Função                                                   |
| -------------------------------------- | -------------------------------------------------------- |
| `docker-compose.yml`                   | Postgres + build remoto (GitHub) da API e do Web + Nginx |
| `default.conf`                         | Proxy reverso (`/` → web, `/api/` → api, Swagger)        |
| `Pneubras-API.postman_collection.json` | Coleção Postman (se presente)                            |

O código-fonte da API e do front está nos repositórios GitHub linkados no topo. O `docker compose up --build` usa esses repositórios remotos, não cópias locais das pastas do projeto.

---
