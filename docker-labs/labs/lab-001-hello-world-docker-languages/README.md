# Lab 001 - Hello World com Docker Languages

## Objetivo

Executar um app simples em container Docker, escolhendo uma linguagem do repositório base.
Para este lab em aula, a linguagem usada será **Python**.

## Duração e dificuldade

- Duração estimada: 20 a 30 minutos
- Dificuldade: iniciante

## Repositório base

- https://github.com/toolbox-playground/hello-world-com-docker-languages

## Pré-requisitos

- Docker Desktop (ou Docker Engine) rodando
- Git

Se você não tiver Docker instalado, use a documentação oficial: https://docs.docker.com/get-docker/

## Fluxo recomendado do aluno

1. Clone o repositório:

```bash
git clone https://github.com/toolbox-playground/hello-world-com-docker-languages.git
cd hello-world-com-docker-languages
```

2. Escolha sua linguagem para o laboratório (nodejs, python, dotnet, java ou go).

3. Para esta aula, entre no diretório **Python**:

```bash
cd python
```

4. Build da imagem:

```bash
docker build -t hello-world-python .
```

5. Run do container:

```bash
docker run -p 5001:5000 hello-world-python
```

6. Acesse no navegador:

```text
http://localhost:5001
```

## Guia prático de comandos Docker (para exercitar)

Com o container rodando, execute os comandos abaixo para praticar:

```bash
# Ver imagens locais
docker images

# Ver containers em execução
docker ps

# Ver todos os containers (inclusive parados)
docker ps -a

# Ver logs do container
docker logs <container_id_ou_nome>

# Seguir logs em tempo real
docker logs -f <container_id_ou_nome>

# Entrar no container para inspeção
docker exec -it <container_id_ou_nome> sh

# Ver detalhes completos do container
docker inspect <container_id_ou_nome>

# Ver uso de recursos (CPU/memória)
docker stats
```

## Como demonstrar em aula (roteiro curto)

1. Mostrar `docker images` com a imagem criada.
2. Subir o container e abrir no browser.
3. Mostrar `docker ps` + `docker logs` para validar execução.
4. Entrar no container com `docker exec -it` e mostrar estrutura básica.

## Exercícios para o aluno

1. Execute comandos Docker à vontade para praticar (`images`, `ps`, `logs`, `exec`, `inspect`, `stats`).
2. Crie um Hello World em Python (ou outra linguagem) e containerize com Docker.
3. Opcional guiado: dentro da pasta do projeto, rode `docker init` para gerar/ajustar o Dockerfile.
4. Interaja com o container usando `docker logs`, `docker exec -it` e `docker ps`.

## Exercício adicional - loop de desenvolvimento com Docker

Objetivo: simular uma alteração de código e repetir o ciclo de entrega.

1. Edite o arquivo `app.py` e altere o texto exibido na página.
2. Faça rebuild da imagem:

```bash
docker build -t hello-world-python .
```

3. Pare e remova o container antigo:

```bash
docker ps
docker stop <container_id_ou_nome>
docker rm <container_id_ou_nome>
```

4. Suba novamente com a nova imagem:

```bash
docker run -p 5001:5000 hello-world-python
```

5. Atualize o navegador em `http://localhost:5001` e valide a mudança.

## Limpeza

```bash
docker ps
docker stop <container_id>
docker rm <container_id>
docker rmi hello-world-python
```

## Referência

- README oficial (raiz): https://github.com/toolbox-playground/hello-world-com-docker-languages/blob/main/README.md
- README oficial (Python): https://github.com/toolbox-playground/hello-world-com-docker-languages/blob/main/python/README.md
