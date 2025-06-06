*** Settings ***
Documentation    Keywords e utilidades para testes do endpoint /carrinhos
Library           Collections
Library           OperatingSystem
Library           FakerLibrary
Library           RequestsLibrary
Resource          ../resources/users_keywords.robot
Resource          ../resources/products_keywords.robot

*** Variables ***
${ENDPOINT_CARRINHO}     /carrinhos

*** Keywords ***

Criar Carrinho Com Produto Valido
    [Arguments]    ${token}    ${id_produto}    ${quantidade}    ${status_esperado}=201
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${prod}=    Create Dictionary    idProduto=${id_produto}    quantidade=${quantidade}
    ${body}=    Create Dictionary    produtos=${prod}
    ${response}=    POST On Session    serverest    ${ENDPOINT_CARRINHO}    headers=${headers}    json=${body}    expected_status=${status_esperado}
    RETURN    ${response}

Criar Carrinho Sem Autenticacao
    [Arguments]    ${id_produto}    ${quantidade}    ${status_esperado}=401
    ${prod}=    Create Dictionary    idProduto=${id_produto}    quantidade=${quantidade}
    ${body}=    Create Dictionary    produtos=${prod}
    ${response}=    POST On Session    serverest    ${ENDPOINT_CARRINHO}    json=${body}    expected_status=${status_esperado}
    RETURN    ${response}

Cancelar Compra E Restaurar Estoque
    [Arguments]    ${token}    ${id_carrinho}    ${status_esperado}=200
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${url}=    Set Variable    ${ENDPOINT_CARRINHO}/cancelar-compra/${id_carrinho}
    ${response}=    DELETE On Session    serverest    ${url}    headers=${headers}    expected_status=${status_esperado}
    RETURN    ${response}

Deletar Carrinho Por ID
    [Arguments]    ${token}    ${id_carrinho}    ${status_esperado}=200
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${url}=    Set Variable    ${ENDPOINT_CARRINHO}/${id_carrinho}
    ${response}=    DELETE On Session    serverest    ${url}    headers=${headers}    expected_status=${status_esperado}
    RETURN    ${response}