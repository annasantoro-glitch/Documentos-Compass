*** Settings ***
Documentation     Suite de testes para operações CRUD da API Restful-booker.
Library           Collections
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/endpoints/auth_keywords.robot
Resource          ../keywords/endpoints/booking_keywords.robot

Suite Setup       Setup Global Do Ambiente
Suite Teardown    Teardown Condicional Da Suite

*** Variables ***
${GLOBAL_API_URL}           ${None}
${GLOBAL_USERNAME}          ${None}
${GLOBAL_PASSWORD}          ${None}
${GLOBAL_BOOKING_ID}        ${None}
${GLOBAL_AUTH_TOKEN}        ${None}
${PRIMEIRO_NOME_TESTE}      ${None}
${SOBRENOME_TESTE}          ${None}

*** Keywords ***
Setup Global Do Ambiente
    ${data}=    Carregar Dados Do Arquivo JSON    config/data.json
    Set Suite Variable    ${GLOBAL_API_URL}    ${data}[api_base_url]
    Set Suite Variable    ${GLOBAL_USERNAME}    ${data}[auth_credentials][username]
    Set Suite Variable    ${GLOBAL_PASSWORD}    ${data}[auth_credentials][password]
    Inicializar Sessao HTTP    ${GLOBAL_API_URL}
    Gerar Nomes Aleatorios Para Reserva

Teardown Condicional Da Suite
    ${resultado}=    Run Keyword And Ignore Error    Deletar Reserva Existente    ${GLOBAL_BOOKING_ID}    ${GLOBAL_AUTH_TOKEN}
    Limpar Variaveis De Teste Globais
    Encerrar Todas As Sessoes HTTP
    Log To Console    *** Teardown Global da Suite Concluído ***

Limpar Variaveis De Teste Globais
    Set Global Variable    ${GLOBAL_BOOKING_ID}    ${None}
    Set Global Variable    ${GLOBAL_AUTH_TOKEN}    ${None}

Tentar Excluir Reserva No Teardown
    ${resultado}=    Run Keyword And Ignore Error    Deletar Reserva Existente    ${GLOBAL_BOOKING_ID}    ${GLOBAL_AUTH_TOKEN}
    ${status_delete}=    Set Variable If    '${resultado[0]}' == 'PASS'    ${resultado[1].status_code}    N/A
    Log To Console    Teardown: Tentativa de excluir reserva ID ${GLOBAL_BOOKING_ID} resultou em status ${status_delete}

Realizar Autenticacao E Armazenar Token Para Testes
    ${auth_token}=    Realizar Autenticacao E Retornar Token    ${GLOBAL_USERNAME}    ${GLOBAL_PASSWORD}
    Set Global Variable    ${GLOBAL_AUTH_TOKEN}    ${auth_token}

Criar Nova Reserva Para Testes
    [Arguments]    ${checkin_date}    ${checkout_date}
    ${id_gerado}=    Criar Nova Reserva E Retornar ID    ${PRIMEIRO_NOME_TESTE}    ${SOBRENOME_TESTE}    ${checkin_date}    ${checkout_date}
    Set Global Variable    ${GLOBAL_BOOKING_ID}    ${id_gerado}
    Log To Console    Reserva criada com ID: ${id_gerado}

*** Test Cases ***
Cenario: Criar E Consultar Nova Reserva Por ID
    [Tags]    POST    GET    CRUD
    Criar Nova Reserva Para Testes    2025-08-01    2025-08-05
    ${resp_get}=    Buscar Detalhes Da Reserva Por ID    ${GLOBAL_BOOKING_ID}
    Should Be Equal As Strings    ${resp_get.json()}[firstname]    ${PRIMEIRO_NOME_TESTE}
    Should Be Equal As Strings    ${resp_get.json()}[lastname]    ${SOBRENOME_TESTE}

Cenario: Atualizar Reserva Existente (PUT)
    [Tags]    PUT    CRUD
    Realizar Autenticacao E Armazenar Token Para Testes
    Criar Nova Reserva Para Testes    2025-09-01    2025-09-10
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    ${resp_put}=    Atualizar Detalhes Da Reserva Completa    ${GLOBAL_BOOKING_ID}    ${headers}
    ...    Jane    Doe    2024-07-01    2024-07-10    200    ${FALSE}    late-checkout
    Should Be Equal As Strings    ${resp_put.json()}[firstname]    Jane
    Should Be Equal As Strings    ${resp_put.json()}[lastname]    Doe

Cenario: Atualizar Parcialmente Reserva (PATCH)
    [Tags]    PATCH    CRUD
    Realizar Autenticacao E Armazenar Token Para Testes
    Criar Nova Reserva Para Testes    2025-10-01    2025-10-05
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    &{payload_patch}=    Create Dictionary    firstname=Johnathan    totalprice=300
    ${resp_patch}=    Atualizar Campo Especifico Da Reserva (PATCH)    ${GLOBAL_BOOKING_ID}    ${headers}    &{payload_patch}
    Should Be Equal As Strings    ${resp_patch.json()}[firstname]    Johnathan
    Should Be Equal As Strings    ${resp_patch.json()}[totalprice]    300

Cenario: Excluir Reserva E Validar Sucesso
    [Tags]    DELETE    CRUD
    Realizar Autenticacao E Armazenar Token Para Testes
    Criar Nova Reserva Para Testes    2025-11-01    2025-11-07
    Deletar Reserva Existente    ${GLOBAL_BOOKING_ID}    ${GLOBAL_AUTH_TOKEN}