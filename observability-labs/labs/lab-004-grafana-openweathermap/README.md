# Lab 004 - Dashboard de clima em tempo real com Grafana e OpenWeatherMap

## Objetivo

Subir o Grafana via Docker com o plugin Infinity, conectar na API gratuita do OpenWeatherMap
e importar um dashboard pronto com dados meteorológicos reais (temperatura, umidade, vento)
da sua cidade.

## Duração e dificuldade

- Duração estimada: 30 a 45 minutos
- Dificuldade: intermediário

## Pré-requisitos

- Docker instalado
- Porta 3000 livre no computador
- Conta gratuita no [OpenWeatherMap](https://openweathermap.org/) para obter uma API Key

## Fluxo recomendado do aluno

### 1. Obter a API Key do OpenWeatherMap

1. Acesse [openweathermap.org](https://openweathermap.org/) e crie uma conta gratuita (sem cartão de crédito).
2. No menu do usuário, acesse **My API Keys** e copie a chave padrão gerada.

> **Atenção:** a chave pode levar até 2 horas para ativar após o cadastro. Se receber erro 401
> ao testar, aguarde e tente novamente. Você pode adiantar os passos 2, 3 e 4 enquanto espera.

Quando a chave estiver ativa, teste no terminal:

```bash
curl "https://api.openweathermap.org/data/2.5/weather?q=Sao+Paulo,BR&appid=<SUA_CHAVE>&units=metric"
```

Resposta esperada: JSON com temperatura, umidade, vento, etc.

### 2. Subir o Grafana com o plugin Infinity

O plugin **Infinity** permite consultar qualquer API REST diretamente como data source no Grafana.

```bash
docker run -d -p 3000:3000 --name=grafana \
  -e "GF_INSTALL_PLUGINS=yesoreyeram-infinity-datasource" \
  grafana/grafana
```

Aguarde ~30 segundos para o plugin ser instalado. Verifique nos logs:

```bash
docker logs grafana 2>&1 | grep -i "infinity\|successfully installed"
```

Linha esperada: `Plugin successfully installed pluginId=yesoreyeram-infinity-datasource`

### 3. Acessar o Grafana

Abra o navegador em [http://localhost:3000](http://localhost:3000).

Login padrão: usuário **`admin`**, senha **`admin`**. Pode clicar em **Skip** na troca de senha.

### 4. Criar o data source Infinity

1. No menu lateral, clique em **Connections > Data sources > Add data source**.
2. Pesquise por **Infinity** e selecione.
3. Clique em **Save & test** — nenhuma configuração adicional é necessária aqui.

### 5. Importar o dashboard de clima

O arquivo `dashboard-openweathermap.json` neste diretório já contém um dashboard pronto
com 6 painéis: Temperatura, Sensação Térmica, Umidade, Velocidade do Vento, Condição do
Tempo e Pressão Atmosférica.

1. No menu lateral, clique em **Dashboards > Import**.
2. Clique em **Upload dashboard JSON file** e selecione o arquivo `dashboard-openweathermap.json`.
3. Em **Infinity**, selecione o data source Infinity que você criou no passo anterior.
4. Clique em **Import**.

### 6. Configurar a API Key e a cidade

O dashboard usa duas variáveis de template no topo da tela:

- **API Key OpenWeatherMap**: cole sua chave gerada no passo 1.
- **Cidade**: no formato `Nome,CODIGO_PAIS` (padrão: `Sao Paulo,BR`). Exemplos:
  - `Rio de Janeiro,BR`
  - `London,GB`
  - `New York,US`

Após preencher as variáveis, os painéis carregam os dados em tempo real.

### 7. Explorar o dashboard

- Clique em qualquer painel e selecione **Edit** para ver como a query foi construída no Infinity.
- Observe como as variáveis `${apikey}` e `${city}` são interpoladas na URL da query.
- O dashboard atualiza automaticamente a cada 5 minutos.

## Como demonstrar em aula (roteiro curto)

1. **[5 min]** Mostrar a criação de conta no OpenWeatherMap e onde pegar a API Key.
   - Avisar que a chave demora até 2h para ativar — fazer o cadastro com antecedência.
2. **[5 min]** Subir o Grafana com o plugin Infinity e confirmar nos logs que instalou.
3. **[5 min]** Criar o data source Infinity.
4. **[5 min]** Importar o `dashboard-openweathermap.json` e preencher as variáveis.
5. **[5 min]** Abrir o editor de um painel e mostrar como o Infinity faz a query na API.
6. **[5 min]** Trocar a cidade pela cidade de um aluno ao vivo e ver os dados mudarem.

## Limpeza

```bash
docker stop grafana && docker rm grafana
```

## Referências

- [Infinity Datasource - Grafana Labs](https://grafana.com/grafana/plugins/yesoreyeram-infinity-datasource/)
- [OpenWeatherMap Current Weather API](https://openweathermap.org/current)
- [grafana/grafana - Docker Hub](https://hub.docker.com/r/grafana/grafana)
