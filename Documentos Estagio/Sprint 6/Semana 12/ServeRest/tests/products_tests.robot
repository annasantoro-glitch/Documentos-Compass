*** Settings ***
Documentation     Suite de testes para o endpoint /produtos, envolvendo cenários de cadastro, listagem, alteração e exclusão de produtos.
Resource          ../resources/products_keywords.robot

Suite Setup       Preparar Ambiente Produtos
Suite Teardown    Encerrar Sessao Produtos

*** Test Cases ***

CT-022 – Cadastro de produto com dados válidos
    ${nome}=    Gerar Nome Produto Aleatorio    ${CAMISETA_NOME}
    ${response}=    Criar Produto Com Dados    ${nome}    99    ${CAMISETA_DESC}    10    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    201
    Should Contain    ${response.text}    Cadastro realizado com sucesso
    ${id}=    Extrair Campo Da Resposta    ${response}    _id
    Set Suite Variable    ${PRODUTO_ID}    ${id}
    Set Suite Variable    ${PRODUTO_NOME}    ${nome}

CT-023 – Cadastro de produto sem autenticação
    ${response}=    Cadastrar Produto Sem Token
    Logar Resposta    ${response}
    Validar Status Code    ${response}    401
    Should Contain    ${response.text}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

CT-024 – Cadastro com nome já utilizado
    ${response}=    Criar Produto Com Dados    ${PRODUTO_NOME}    199.99    Fone com cancelamento de ruído    5    ${TOKEN_VALIDO}    expected_status=400
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    Já existe produto com esse nome

CT-025 – Edição de produto com dados válidos
    ${response}=    Editar Produto    ${PRODUTO_ID}    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    Registro alterado com sucesso

# CT-026 – PUT em produto com ID inexistente
# Este cenário está pendente de implementação.
# Bloqueado por ambiguidade nas regras de negócio da API (Swagger permite criação implícita via PUT).

CT-027 – Deletar produto sem estar vinculado a carrinho
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Para Deletar
    ${response}=    Criar Produto Com Dados    ${nome}    50    Produto para ser deletado    3    ${TOKEN_VALIDO}
    ${id}=    Extrair Campo Da Resposta    ${response}    _id
    ${response}=    Deletar Produto    ${id}    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    Registro excluído com sucesso

CT-028 – Deletar produto vinculado a carrinho
    # Este teste requer implementação adicional para criar um carrinho com o produto
    # Como não temos acesso às keywords de carrinho, vamos simular com um ID conhecido
    ${response}=    Deletar Produto    BeeJh5lz3k6kSIzA    ${TOKEN_VALIDO}    expected_status=400
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    Não é possível excluir produto que faz parte de carrinho

CT-029 – Listar todos os produtos
    ${response}=    Listar Produtos
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    produtos
    Should Contain    ${response.text}    quantidade

CT-030 – Criar produto com campo obrigatório ausente
    ${response}=    Cadastrar Produto Sem Quantidade    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    quantidade é obrigatório

CT-031 – Criar produto com quantidade negativa
    ${response}=    Cadastrar Produto Com Quantidade Negativa    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    quantidade deve ser maior ou igual a 0

CT-032 – Criar produto com nome em branco
    ${response}=    Cadastrar Produto Sem Nome    ${TOKEN_VALIDO}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    nome não pode ficar em branco