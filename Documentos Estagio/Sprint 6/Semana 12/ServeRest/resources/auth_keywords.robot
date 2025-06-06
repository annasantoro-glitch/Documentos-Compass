*** Settings ***
Documentation     Keywords para testes relacionados à autenticação e validade de tokens.
Resource          ../resources/login_keywords.robot

*** Variables ***
${ENDPOINT_PROTEGIDO}    /produtos

*** Keywords ***

Obter Token Válido
    ${usuario}=    Criar Usuario Valido Para Login
    ${resposta}=   Realizar Login Valido    ${usuario.email}    ${usuario.senha}
    ${token}=      Extrair Campo Da Resposta    ${resposta}    authorization
    RETURN         ${token}

Acessar Endpoint Protegido Com Token
    [Arguments]    ${token}    ${endpoint}=${ENDPOINT_PROTEGIDO}    ${status_esperado}=200
    ${headers}=    Create Dictionary    Authorization=${token}
    ${resposta}=   GET On Session    serverest    ${endpoint}    headers=${headers}    expected_status=${status_esperado}
    RETURN         ${resposta}

Token Expirado Ou Invalido
    [Arguments]    ${endpoint}=${ENDPOINT_PROTEGIDO}
    ${token_invalido}=    Set Variable    Bearer token_falso_invalido
    ${resposta}=   Acessar Endpoint Protegido Com Token    ${token_invalido}    ${endpoint}    401
    RETURN         ${resposta}