# Lab 000 - Primeiro Contato com Docker

## Objetivo

Fazer o setup inicial e validar que o Docker está funcionando no ambiente do aluno.

## Duração e dificuldade

- Duração estimada: 10 a 20 minutos
- Dificuldade: iniciante

## Repositório base

- [docker-exemplo-basico](https://github.com/toolbox-playground/docker-exemplo-basico/tree/main)

## Pré-requisitos

- Docker Desktop (ou Docker Engine)

Se você ainda não tiver Docker instalado, use a documentação oficial: https://www.docker.com/products/docker-desktop/

## Fluxo recomendado do aluno

1. Verifique a versão do Docker:

```bash
docker --version
```

2. Rode o container de teste:

```bash
docker run hello-world
```

3. Verifique containers em execução:

```bash
docker ps
```

4. Verifique também os containers parados:

```bash
docker ps -a
```

## Como demonstrar em aula (roteiro curto)

1. Mostrar `docker --version`.
2. Rodar `docker run hello-world`.
3. Mostrar diferença entre `docker ps` e `docker ps -a`.

## Referência

- README oficial do exercício: [abrir](https://github.com/toolbox-playground/docker-exemplo-basico/blob/main/README.md)
