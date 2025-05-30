*** Settings ***
Documentation     Suite de testes para o endpoint de autenticação da API Restful-booker.
Library           Collections
Resource          ../keywords/endpoints/auth_keywords.robot

Suite Setup       Setup Global Do Ambiente
Suite Teardown    Encerrar Todas As Sessoes HTTP

*** Variables ***
${GLOBAL_API_URL}           ${None}
${GLOBAL_USERNAME}          ${None}
${GLOBAL_PASSWORD}          ${None}

*** Keywords ***
Setup Global Do Ambiente
    ${data}=    Carregar Dados Do Arquivo JSON    config/data.json
    Set Suite Variable    ${GLOBAL_API_URL}    ${data}[api_base_url]
    Set Suite Variable    ${GLOBAL_USERNAME}    ${data}[auth_credentials][username]
    Set Suite Variable    ${GLOBAL_PASSWORD}    ${data}[auth_credentials][password]
    Inicializar Sessao HTTP    ${GLOBAL_API_URL}

*** Test Cases ***
Cenario: Autenticacao Com Credenciais Validas
    [Tags]    AUTH    Smoke
    ${auth_token}=    Realizar Autenticacao E Retornar Token    ${GLOBAL_USERNAME}    ${GLOBAL_PASSWORD}
    Should Not Be Empty    ${auth_token}
    Log To Console    Token de autenticação obtido: ${auth_token}