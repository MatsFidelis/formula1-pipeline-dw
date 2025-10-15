# Fórmula 1 DataWarehouse Pipeline

Este projeto tem como objetivo principal **estudo e aprendizado de engenharia de dados**, utilizando uma **arquitetura em medalhão (Bronze → Silver → Gold)**.  
Os dados passam por uma sequência de transformações e limpeza, inicialmente manipulados **manualmente em notebooks Jupyter** e posteriormente através de um **pipeline automatizado com Apache Airflow e Docker**.  

O resultado final é utilizado para **visualização e análise de dados**, podendo ser integrado a ferramentas como Power BI ou Tableau.

# Proposta de Arquitetura

A arquitetura do projeto contempla dois fluxos distintos:

1. **Pipeline manual**
   - Processamento local via **notebooks Jupyter**.
   - Geração dos arquivos **Silver e Gold**.
   - Consumo posterior pelo container PostgreSQL para análise e visualização.

2. **Pipeline automatizado**
   - Orquestração com **Apache Airflow** dentro de containers Docker.
   - Execução dos scripts Python que processam os dados desde Bronze → Silver → Gold.
   - População direta do **PostgreSQL** dentro do container, garantindo reprodutibilidade do pipeline.


## Visão geral do pipeline

### Extração/Ingestão
- **Origem:** arquivos CSV brutos armazenados em `data/bronze/`.
- **Procedimento:** download ou exportação manual dos arquivos.
- **Observação:** nesta versão acadêmica, o processo é manual, garantindo integridade dos dados de origem.

### Bronze (Dado Bruto)
- **Local:** `data/bronze/`
- **Descrição:** arquivos CSV originais, sem alterações, que representam a camada de ingestão inicial.

### Silver (Transformação e Consolidação)
- **Local:** `data/silver/`
- **Notebook:** `notebooks/01_bronze_to_silver.ipynb`
- **Principais etapas:**  
  - Limpeza de dados (valores nulos, duplicatas)  
  - Normalização de colunas  
  - Conversão de tipos de dados  
- **Saída:** arquivos Parquet ou CSV tratados, prontos para a camada Gold.

### Gold (Dados finais para análise)
- **Local:** `data/gold/`
- **Notebook:** `notebooks/02_silver_to_gold.ipynb`
- **Principais etapas:**  
  - Agregações e consolidações finais  
  - Preparação de datasets para análise/visualização  
- **Saída:** arquivos finais para consumo pelo PostgreSQL ou ferramentas de BI.

## Notebooks do Projeto

### **01_bronze_to_silver.ipynb**
- **Objetivo:** Processar os dados brutos da camada Bronze e gerar a camada Silver.
- **Entradas:** CSVs brutos em `data/bronze/`
- **Transformações aplicadas:**  
  - Limpeza de valores nulos e duplicados  
  - Normalização e padronização de colunas  
  - Conversão para Parquet  
- **Saída:** arquivos Parquet/CSV em `data/silver/`

### **02_silver_to_gold.ipynb**
- **Objetivo:** Consolidar os dados da camada Silver e gerar a camada Gold, pronta para análise.
- **Entradas:** arquivos Parquet/CSV em `data/silver/`
- **Transformações aplicadas:**  
  - Agregações e cálculos de métricas finais  
  - Preparação do dataset final para BI  
- **Saída:** arquivos Parquet/CSV em `data/gold/`

## Rodando o Projeto

## Estrutura do repositório

```
formula1_pipeline/
│
├── data/                           # Armazenamento de dados
│   ├── bronze/                     # CSVs brutos (entrada)
│   ├── silver/                     # Dados tratados (via notebooks ou pipeline)
│   └── gold/                       # Dados finais prontos para análise / PostgreSQL
│
├── notebooks/                       # Notebooks Jupyter para estudo manual
│   ├── 01_bronze_to_silver.ipynb
│   └── 02_silver_to_gold.ipynb
│
├── scripts/                         # Scripts Python para pipeline automático
│   ├── bronze_to_silver.py
│   └── silver_to_gold.py
│
├── dags/                            # DAGs do Airflow (pipeline automático)
│   └── etl_pipeline_estudo1.py
│
├── docker/                          # Dockerfiles e docker-compose
│   ├── postgres/                    # Configuração do PostgreSQL
│   │   ├── Dockerfile               # Se necessário para customização
│   │   └── init.sql                 # Scripts iniciais (schemas, tabelas)
│   │
│   ├── airflow/                     # Configuração do Airflow
│   │   ├── Dockerfile               # Base: apache/airflow, instalar dependências
│   │   └── requirements.txt         # Bibliotecas Python necessárias (pandas, pyarrow etc.)
│   │
│   ├── docker-compose-manual.yml    # Compose para fluxo manual (PostgreSQL + pgAdmin opcional)
│   └── docker-compose-automatic.yml # Compose para pipeline automático (PostgreSQL + Airflow)
│
├── logs/                             # Logs de execução dos scripts e Airflow
│
├── .gitignore                        # Ignorar arquivos temporários / dados grandes
│
├── README.md                         # Documentação do projeto
│
└── requirements.txt                  # Dependências Python para notebooks / scripts
```

