# ServeRest API Test Automation

Projeto de automação de testes para a API ServeRest, desenvolvido como parte do Challenge 02 da Compass UOL.

## Descrição Geral

Este projeto implementa uma estrutura completa de automação de testes para a API ServeRest (https://serverest.dev/), utilizando Robot Framework e Python. A automação foi desenvolvida seguindo boas práticas de engenharia de testes, com foco em:

- Organização modular de testes
- Reutilização de código
- Geração de dados dinâmicos
- Validação completa de endpoints
- Testes positivos e negativos

## Tecnologias Utilizadas

- **Robot Framework**: Framework de automação de testes
- **Python**: Linguagem base para extensões e bibliotecas
- **RequestsLibrary**: Biblioteca para requisições HTTP
- **FakerLibrary**: Geração de dados aleatórios
- **JSONLibrary**: Manipulação de dados JSON
- **BuiltIn**: Funcionalidades nativas do Robot Framework
- **String**: Manipulação de strings
- **Collections**: Manipulação de coleções de dados
- **OperatingSystem**: Interação com o sistema operacional

## Estrutura do Projeto

```
ServeRest/
├── resources/              # Keywords e recursos reutilizáveis
│   ├── base.robot          # Configurações base e funções utilitárias
│   ├── auth_keywords.robot # Keywords para autenticação
│   ├── login_keywords.robot # Keywords para login
│   ├── users_keywords.robot # Keywords para usuários
│   ├── products_keywords.robot # Keywords para produtos
│   └── cart_keywords.robot # Keywords para carrinho
├── tests/                  # Suítes de teste
│   ├── auth_tests.robot    # Testes de autenticação
│   ├── login_tests.robot   # Testes de login
│   ├── users_tests.robot   # Testes de usuários
│   ├── products_tests.robot # Testes de produtos
│   └── cart_tests.robot    # Testes de carrinho
└── results/                # Relatórios de execução
    ├── auth/
    ├── login/
    ├── users/
    ├── products/
    └── cart/
```

## Execução dos Testes

### Pré-requisitos

1. Python 3.7+ instalado
2. Robot Framework instalado
3. Bibliotecas necessárias instaladas

```bash
pip install robotframework
pip install robotframework-requests
pip install robotframework-jsonlibrary
pip install robotframework-faker
```

### Comandos para Execução

Para executar todos os testes:

```bash
robot -d results tests/
```

Para executar uma suíte específica:

```bash
robot -d results/login tests/login_tests.robot
```

Para executar um teste específico:

```bash
robot -d results/users -t "CT-001 - Cadastro válido de novo usuário" tests/users_tests.robot
```

## Status dos Endpoints

### Endpoints Completos e Revisados

- **/usuarios**: Implementação completa com testes CRUD e validações de regras de negócio
  ```robot
  CT-001 - Cadastro válido de novo usuário
  CT-002 - Cadastro com e-mail duplicado
  CT-003 - Cadastro com e-mail inválido
  ...
  ```

- **/login**: Implementação completa com testes de credenciais válidas e inválidas
  ```robot
  CT-015 - Login com credenciais válidas
  CT-016 - Login com usuário não cadastrado
  CT-017 - Login com senha inválida
  CT-018 - Login sem fornecer senha
  CT-019 - Login sem fornecer e-mail
  ```

- **/auth**: Implementação completa com testes de validade de token
  ```robot
  CT-020 - Validade do token (10 minutos)
  CT-021 - Reutilização de token após logout ou expiração
  ```

### Endpoints em Progresso

- **/produtos**: Implementação parcial, faltando alguns cenários de teste
  ```robot
  CT-022 – Cadastro de produto com dados válidos
  CT-023 – Cadastro de produto sem autenticação
  ...
  CT-026 – PUT em produto com ID inexistente (pendente)
  ```

### Endpoints Não Iniciados

- **/carrinhos**: Implementação não iniciada
  ```
  # EM ANDAMENTO
  ```

## Próximos Passos

1. Finalizar implementação dos testes de produtos
   - Completar cenário CT-026 (PUT em produto com ID inexistente)
   - Adicionar mais testes negativos

2. Iniciar implementação dos testes de carrinho
   - Desenvolver keywords para manipulação de carrinhos
   - Implementar testes CRUD completos

3. Melhorar cobertura de testes negativos em todos os endpoints

4. Implementar sessão CRUD completa para todos os endpoints

5. Refatorar código para melhorar reuso e manutenibilidade

## Exemplos de Implementação

### Exemplo de Keyword para Criação de Produto

```robot
Criar Produto Com Dados
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}    ${token}=None    ${expected_status}=201
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${payload}=    Create Dictionary
    ...    nome=${nome}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    ${response}=    POST On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=${expected_status}
    RETURN    ${response}
```

### Exemplo de Teste de Login

```robot
CT-015 - Login com credenciais válidas
    ${usuario}=    Criar Usuario Valido Para Login
    ${response}=    Realizar Login Valido    ${usuario.email}    ${usuario.senha}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    Login realizado com sucesso
    ${token}=    Extrair Campo Da Resposta    ${response}    authorization
    Set Test Variable    ${TOKEN_VALIDO}    ${token}
```

## Licença

Este projeto está sob a licença MIT.

---

Desenvolvido como parte do programa de formação da Compass UOL.