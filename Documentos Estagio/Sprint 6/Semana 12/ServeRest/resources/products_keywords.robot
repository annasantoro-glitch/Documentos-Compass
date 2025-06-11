*** Settings ***
Documentation    Keywords e utilidades para testes do endpoint /produtos
Resource         ../resources/base.robot
Resource         ../resources/login_keywords.robot

*** Variables ***
${ENDPOINT_PRODUTOS}        /produtos
${CAMISETA_NOME}            Camiseta Tech
${CAMISETA_DESC}            Camiseta com estampa tecnológica
${CAMISETA_DESC_EDITADA}    Camiseta tech com novo design

*** Keywords ***

Criar Sessao Produtos
    Criar Sessão API

Encerrar Sessao Produtos
    Encerrar Sessão API

Preparar Ambiente Produtos
    Criar Sessão API
    ${usuario}=    Criar Usuario Valido Para Login
    ${response_login}=    Realizar Login Valido    ${usuario.email}    ${usuario.senha}
    Logar Resposta    ${response_login}
    ${token}=    Extrair Campo Da Resposta    ${response_login}    authorization
    Should Not Be Empty    ${token}    Token não foi gerado corretamente!
    Set Suite Variable    ${TOKEN_VALIDO}    ${token}
    ${nome_produto}=    Gerar Nome Produto Aleatorio    Produto Base
    ${response_produto}=    Criar Produto Com Dados    ${nome_produto}    99    Desc    5    ${token}
    Logar Resposta    ${response_produto}
    ${id}=    Extrair Campo Da Resposta    ${response_produto}    _id
    Set Suite Variable    ${PRODUTO_ID}    ${id}
    Set Suite Variable    ${PRODUTO_NOME}    ${nome_produto}

Gerar Nome Produto Aleatorio
    [Arguments]    ${prefixo}
    ${sufixo}=    Generate Random String    5
    ${nome}=    Set Variable    ${prefixo} ${sufixo}
    RETURN    ${nome}

Criar Payload Produto Sem Campo
    [Arguments]    ${campo}
    ${payload}=    Create Dictionary
    ...    nome=Produto Padrão
    ...    preco=99
    ...    descricao=Descrição padrão
    ...    quantidade=10
    Remove From Dictionary    ${payload}    ${campo}
    RETURN    ${payload}

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

Criar Produto Camiseta Com Token
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    ${CAMISETA_NOME}
    ${response}=    Criar Produto Com Dados    ${nome}    99    ${CAMISETA_DESC}    10    ${token}
    RETURN    ${nome}    ${response}

Cadastrar Produto Válido
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Teste
    ${response}=    Criar Produto Com Dados    ${nome}    100    Produto de teste válido    5    ${token}
    RETURN    ${nome}    ${response}

Cadastrar Produto Sem Token
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Sem Token
    ${response}=    Criar Produto Com Dados    ${nome}    90    Produto sem autenticação    3    ${EMPTY}    expected_status=401
    RETURN    ${response}

Cadastrar Produto Nome Repetido
    [Arguments]    ${token}
    ${nome}=    Set Variable    Produto Repetido
    ${response1}=    Criar Produto Com Dados    ${nome}    120    Produto original    5    ${token}
    Logar Resposta    ${response1}
    ${response2}=    Criar Produto Com Dados    ${nome}    130    Produto duplicado    4    ${token}    expected_status=400
    Logar Resposta    ${response2}
    RETURN    ${response2}

Cadastrar Produto Com Quantidade Negativa
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Inválido
    ${response}=    Criar Produto Com Dados    ${nome}    70    Produto com erro    -3    ${token}    expected_status=400
    RETURN    ${response}

Cadastrar Produto Sem Nome
    [Arguments]    ${token}
    ${response}=    Criar Produto Com Dados    ${EMPTY}    100    Produto sem nome    2    ${token}    expected_status=400
    RETURN    ${response}

Cadastrar Produto Sem Preço
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Sem Preço
    ${payload}=    Criar Payload Produto Sem Campo    preco
    Set To Dictionary    ${payload}    nome=${nome}
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    POST On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=400
    RETURN    ${response}

Cadastrar Produto Sem Descrição
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Sem Desc
    ${payload}=    Criar Payload Produto Sem Campo    descricao
    Set To Dictionary    ${payload}    nome=${nome}
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    POST On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=400
    RETURN    ${response}

Cadastrar Produto Sem Quantidade
    [Arguments]    ${token}
    ${nome}=    Gerar Nome Produto Aleatorio    Produto Sem Qtd
    ${payload}=    Criar Payload Produto Sem Campo    quantidade
    Set To Dictionary    ${payload}    nome=${nome}
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    POST On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=400
    RETURN    ${response}

Editar Produto
    [Arguments]    ${id}    ${token}    ${expected_status}=200
    ${payload}=    Create Dictionary
    ...    nome=${CAMISETA_NOME}
    ...    preco=89.90
    ...    descricao=${CAMISETA_DESC_EDITADA}
    ...    quantidade=10
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    PUT On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}/${id}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Editar Produto Com Payload
    [Arguments]    ${id}    ${payload}    ${token}    ${expected_status}=200
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    PUT On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}/${id}
    ...    json=${payload}
    ...    headers=${headers}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Deletar Produto
    [Arguments]    ${id}    ${token}    ${expected_status}=200
    ${headers}=    Criar Headers Autenticacao    ${token}
    ${response}=    DELETE On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}/${id}
    ...    headers=${headers}
    ...    expected_status=${expected_status}
    RETURN    ${response}

Listar Produtos
    [Arguments]    ${expected_status}=200
    ${response}=    GET On Session
    ...    serverest
    ...    ${ENDPOINT_PRODUTOS}
    ...    expected_status=${expected_status}
    RETURN    ${response}