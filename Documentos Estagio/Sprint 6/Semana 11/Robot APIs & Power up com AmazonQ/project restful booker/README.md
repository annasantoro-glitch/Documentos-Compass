# Projeto de Automação de Testes - Restful Booker API

Este projeto implementa testes automatizados para a API Restful Booker utilizando Robot Framework, com foco em boas práticas de automação, organização modular e validações robustas.

A API Restful Booker simula um sistema de reservas de hotel, permitindo operações como criação, leitura, atualização e exclusão de reservas, além de autenticação de usuários. É amplamente utilizada para práticas de testes de APIs RESTful, fornecendo endpoints públicos para aprendizado e validação de técnicas de automação.

API utilizada: Restful Booker API
Documentação oficial: [Swagger Docs](https://restful-booker.herokuapp.com/apidoc/index.html)

## Tecnologias Utilizadas

- **Robot Framework**
- **Python 3.x**
- **Bibliotecas Robot Framework**:
  - RequestsLibrary
  - JSONLibrary
  - Collections
  - String
  - DateTime
  - Process

## Pré-requisitos e Configuração Inicial

1. Python 3.x instalado
- Certifique-se de que o Python está corretamente instalado em sua máquina. [Baixe o Python aqui](https://www.python.org/downloads/)

2. Criar e ativar um ambiente virtual (Opcional)
Recomenda-se o uso de um ambiente virtual para evitar conflitos de dependências:
```bash
python -m venv venv
```

# Linux/Mac
```bash
source venv/bin/activate
```

# Windows
```bash
venv\Scripts\activate
```

3. Instalação das dependências:
```bash
pip install robotframework robotframework-requests robotframework-jsonlibrary
```

## Estrutura do Projeto

```
project_restful_booker/
├── config/
│   └── data.json                  # Configurações da API (URL, credenciais)
├── keywords/
│   ├── endpoints/
│   │   ├── auth_keywords.robot    # Keywords para autenticação
│   │   └── booking_keywords.robot # Keywords para operações de reservas
│   ├── common_keywords.robot      # Keywords comuns reutilizáveis
│   └── performance_keywords.robot # Keywords para testes de performance
├── results/
│   └── performance/              # Resultados dos testes de performance
│       ├── metrics.csv           # Métricas coletadas
│       └── performance_report.html # Relatório visual
├── tests/
│   ├── auth_tests.robot          # Testes de autenticação
│   ├── booking_crud_tests.robot  # Testes CRUD de reservas
│   ├── booking_filter_tests.robot # Testes de filtros
│   └── performance_tests.robot   # Testes de performance
└── README.md
```

## Funcionalidades Implementadas

### Testes de Performance
Os testes de performance medem o tempo de resposta para os endpoints principais da API, com simulações simples de múltiplos usuários. O foco está em validar a estabilidade e o desempenho básico da API, coletando e armazenando métricas de: tempo mínimo, máximo e médio. Além disso, fornece relatórios visuais para análise de tendências.

### Geração Dinâmica de Dados (Implementação Parcial)
A geração de dados aleatórios está parcialmente implementada através de argumentos nos testes e keywords flexíveis, e será expandida no futuro para uma library dedicada, caso o projeto evolua para testes mais complexos.

## Como Executar os Testes

### Testes Funcionais
```bash
robot -d results tests/booking_crud_tests.robot
```

### Testes de Performance
```bash
robot -d results tests/performance_tests.robot
```

### Execução Paralela (não suportada - para referência)
# Exemplo de comando para execução paralela com Pabot (não suportado neste projeto)

Requer instalação do Pabot:
```bash
pip install robotframework-
```

```bash
pabot --processes 4 tests/
```

### Todos os Testes
```bash
robot -d results tests/
```

## Relatórios de Performance

Após a execução dos testes de performance, um relatório HTML é gerado em `results/performance/performance_report.html` com visualizações gráficas das métricas coletadas.

## Limitações Conhecidas

### Execução Paralela (Pabot)
A execução paralela foi analisada mas **não é suportada** devido a:
- Conflitos com sessões HTTP compartilhadas
- Dependências entre variáveis globais
- Problemas na limpeza de recursos compartilhados

## Relatório Detalhado
Junto a esta atividade, está incluído o relatório "Robot Framework + APIs & Insights de Amazon Q", o qual complementa a documentação do projeto, oferecendo uma visão aprofundada das sugestões geradas pelo Amazon Q para aprimoramento do projeto, bem como as decisões técnicas tomadas e os resultados obtidos após a implementação das melhorias.

## Considerações Finais

Este projeto foi desenvolvido para fins de aprendizado e demonstração de técnicas de automação de testes em APIs RESTful. As implementações seguem boas práticas de automação e podem ser expandidas para cobrir novos cenários.

Feedbacks e sugestões de melhorias são bem-vindos para evolução contínua do projeto.