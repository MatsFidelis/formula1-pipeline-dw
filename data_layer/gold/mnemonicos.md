# Padrão de Mnemônicos das Entidades - DW F1

Convenções de nomenclatura aplicadas às camadas Silver e Gold do pipeline de dados

## Regras Gerais

- Utilizar snake_case para todos os nomes.
- Todos os identificadores devem estar em minúsculas.
- Tamanho máximo recomnedado: 30 Caracteres

## Tabela de Mnêmonicos

| Prefixo | Sigla | Palavra | Exemplo |
|---------|-------|---------|---------|
| Tabela Dimensão | `DIM` | Dimensão | DIM_CORRIDA |
| Tabela Fato| `FAT` | Fato | FAT_RESULTADOS |
| Chave Estrangeira | `fk` | Foreign Key | srk_status_fk |
| Chave (surrogate) | `srk` | Surrogate Key | srk_status_fk |
| Latitude | `lat` | Latitude | 12.232 |
| Longitude | `lng` | Longitude | 17.232 |
| Referencia | `ref` | Reference | 123 |