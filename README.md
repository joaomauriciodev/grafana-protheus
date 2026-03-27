# Grafana Protheus - Monitoramento de Logs

Sistema de centralização e visualização de logs do **Protheus (TOTVS)** utilizando a stack **Grafana + Loki + Promtail**.

## Visão Geral

O projeto integra o ERP Protheus com ferramentas de observabilidade para monitoramento em tempo real de logs de aplicação.

**Fluxo de dados:**

```
Protheus (GravaLog.prw) → Arquivos .log (logs/fontes/)
                                  ↓
                      Promtail (coleta e envia)
                                  ↓
                         Loki (agrega logs)
                                  ↓
                    Grafana (visualização e alertas)
```

## Componentes

| Componente | Porta | Função |
|------------|-------|--------|
| Grafana    | 3000  | Interface de dashboards e visualização |
| Loki       | 3100  | Agregação e armazenamento de logs |
| Promtail   | 9080  | Coleta logs do Protheus e envia ao Loki |

## Pré-requisitos

- [Docker](https://www.docker.com/) e Docker Compose
- Protheus instalado em `C:/TOTVS/protheus_data/`

## Como usar

### 1. Subir a stack de monitoramento

```bash
docker compose up -d
```

### 2. Acessar o Grafana

Abra [http://localhost:3000](http://localhost:3000) no navegador.

- **Usuário:** `admin`
- **Senha:** `admin`

O dashboard **Protheus Logs** é provisionado automaticamente.

### 3. Integrar o Protheus

Copie os arquivos ADVPL para o seu projeto Protheus:

- `GravaLog.prw` — Função principal de escrita de logs
- `ExemLogs.prw` — Exemplo de uso

Compile e utilize a função `GravaLog` nas suas rotinas:

```advpl
// GravaLog(cTipo, cDescricao, cRotina)
GravaLog("INFO",  "Iniciando emissao de NF",           "MATA410")
GravaLog("DEBUG", "CFOP utilizado: 5102",              "MATA410")
GravaLog("WARN",  "Estoque abaixo do minimo",          "MATA410")
GravaLog("ERROR", "Falha na gravacao da NF: sem permissao", "MATA410")
```

Os logs são gravados em `./logs/fontes/<ROTINA>.log` no formato:

```
[DD/MM/YYYY HH:MM:SS] [TIPO] [ROTINA] [USUARIO] [DESCRICAO]
```

## Dashboard

O dashboard **Protheus Logs** inclui:

- **Total de logs** — contador geral do período
- **ERROs / WARNs / INFOs / DEBUGs** — contadores por nível com alertas visuais
- **Volume por tipo ao longo do tempo** — gráfico de barras empilhadas
- **Todos os logs** — visualizador de logs brutos
- **Apenas ERROs** — filtro focado em erros

## Estrutura do Projeto

```
grafana-protheus/
├── docker-compose.yml              # Orquestração dos serviços
├── loki-config.yml                 # Configuração do Loki
├── promtail-config.yml             # Configuração do Promtail
├── GravaLog.prw                    # Função ADVPL de logging
├── ExemLogs.prw                    # Exemplo de uso
└── grafana/
    └── provisioning/
        ├── dashboards/
        │   ├── dashboard.yaml      # Config de provisionamento
        │   └── protheus-logs-dashboard.json
        └── datasources/
            └── loki.yaml           # Datasource Loki
```

## Configurações relevantes

- Logs são retidos por **7 dias** no Loki
- O Grafana atualiza os dados a cada **30 segundos**
- O ambiente padrão é rotulado como `ambiente="producao"`
- Para alterar o caminho dos logs do Protheus, edite o volume em `docker-compose.yml`:

```yaml
volumes:
  - C:/TOTVS/protheus_data/logs/fontes:/logs/fontes
```
## Exemplo Dashboard
<img width="1616" height="780" alt="image" src="https://github.com/user-attachments/assets/808fbc52-e205-4bb7-898f-6202039bfa48" />

