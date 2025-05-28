*** Settings ***
Documentation     Suite de testes para operações de listagem e filtro da API Restful-booker.
Library           Collections
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/endpoints/booking_keywords.robot

Suite Setup       Setup Global Do Ambiente
Suite Teardown    Encerrar Todas As Sessoes HTTP

*** Variables ***
${GLOBAL_API_URL}           ${None}
${PRIMEIRO_NOME_TESTE}      ${None}
${SOBRENOME_TESTE}          ${None}

*** Keywords ***
Setup Global Do Ambiente
    ${data}=    Carregar Dados Do Arquivo JSON    config/data.json
    Set Suite Variable    ${GLOBAL_API_URL}    ${data}[api_base_url]
    Inicializar Sessao HTTP    ${GLOBAL_API_URL}
    Gerar Nomes Aleatorios Para Reserva

*** Test Cases ***
Cenario: Listar Todas As Reservas
    [Tags]    GET
    ${resp_list}=    Listar Todas As Reservas
    Should Not Be Empty    ${resp_list.json()}

Cenario: Buscar Reserva Por Nome E Sobrenome
    [Tags]    GET    Filtro
    # Criar uma reserva para garantir que o filtro encontre algo
    ${id_reserva_para_filtro}=    Criar Nova Reserva E Retornar ID
    ...    ${PRIMEIRO_NOME_TESTE}    ${SOBRENOME_TESTE}    2025-06-01    2025-06-05
    ${params}=    Create Dictionary    firstname=${PRIMEIRO_NOME_TESTE}    lastname=${SOBRENOME_TESTE}
    ${resp_filtro}=    Buscar Reservas Por Filtro    &{params}
    Should Not Be Empty    ${resp_filtro.json()}

Cenario: Buscar Reserva Por Intervalo De Datas
    [Tags]    GET    Filtro
    # Criar uma reserva para garantir que o filtro encontre algo
    ${id_reserva_para_filtro}=    Criar Nova Reserva E Retornar ID
    ...    ${PRIMEIRO_NOME_TESTE}    ${SOBRENOME_TESTE}    2025-07-01    2025-07-10
    ${params}=    Create Dictionary    checkin=2025-07-01    checkout=2025-07-10
    ${resp_filtro}=    Buscar Reservas Por Filtro    &{params}
    Validar Codigo De Resposta    ${resp_filtro}    200
    Log To Console    ${resp_filtro.json()}