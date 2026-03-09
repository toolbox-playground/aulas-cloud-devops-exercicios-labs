# Lab 002 - Trilha Guiada (Docker Dominando Containers)

## Objetivo

Seguir uma trilha externa de exercícios Docker, de forma rápida e prática, usando links diretos por lab.

## Repositório base

- [docker-dominando-containers](https://github.com/toolbox-playground/docker-dominando-containers)

## Como usar este lab

1. Abra o repositório base.
2. Escolha os exercícios conforme seu nível.
3. Execute os labs em sequência (básico -> intermediário).

## Exercícios básicos

- **01-01** - Instalar e validar Docker (`docker --version` e `hello-world`): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-01.md)
- **01-02** - Criar container simples com Alpine + `curl`: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-02.md)
- **01-03** - Servir página HTML estática com Nginx: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-03.md)
- **01-04** - Subir servidor web Python (Flask) em container: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-04.md)
- **01-05** - Persistir dados com Docker Volumes: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-05.md)
- **01-06** - Construir imagem personalizada com Dockerfile: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-06.md)
- **01-07** - Orquestrar múltiplos containers com Docker Compose: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-07.md)
- **01-08** - Escanear imagem por vulnerabilidades (Docker Scout): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-08.md)
- **01-09** - Executar comandos em container em execução (`docker exec`): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-09.md)
- **01-10** - Limpar recursos não utilizados (`docker system prune`): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/1_basicos/01-10.md)

## Exercícios intermediários

- **02-01** - Autenticar em registry para `push`/`pull` (`docker login`): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/2_intermediarios/02-01.md)
- **02-02** - Compose com dependência entre serviços (`depends_on`): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/2_intermediarios/02-02.md)
- **02-03** - Implementar rotas/comunicação entre containers via rede Docker: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/2_intermediarios/02-03.md)
- **03-04** - Compartilhar dados entre containers usando volume: [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/2_intermediarios/03-04.md)
- **03-05** - Monitorar recursos com métricas (cAdvisor, Prometheus, Grafana): [abrir lab](https://github.com/toolbox-playground/docker-dominando-containers/blob/main/exercicios/2_intermediarios/03-05.md)

## Sugestão para aula (45 min)

- Faça 3 labs: `01-03` (Nginx) + `01-04` (Python) + `01-09` (`docker exec`).
- Se sobrar tempo, faça `02-02` (Compose com dependências).
