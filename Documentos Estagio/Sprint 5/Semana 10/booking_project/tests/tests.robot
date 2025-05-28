*** Settings ***
Documentation     Arquivo de suite de testes para a API Restful-booker.
Library           RequestsLibrary
Library           String
Library           Collections
Resource          ../keywords/keywords.robot

Suite Setup       Setup Global Do Ambiente
Suite Teardown    Teardown Condicional Da Suite

*** Variables ***
${GLOBAL_BOOKING_ID}      ${None}
${GLOBAL_AUTH_TOKEN}      ${None}
${ULTIMA_RESPOSTA_HTTP}   ${None}

*** Keywords ***

# --- Keywords de Configuração e Limpeza da Suite ---
Setup Global Do Ambiente
    Inicializar Sessao HTTP
    Gerar Nomes Aleatorios Para Reserva

Teardown Condicional Da Suite
    Run Keyword If    '${GLOBAL_BOOKING_ID}' != 'None'    Tentar Excluir Reserva No Teardown
    Limpar Variaveis De Teste Globais
    Encerrar Todas As Sessoes HTTP
    Log To Console    *** Teardown Global da Suite Concluído ***

Limpar Variaveis De Teste Globais
    Set Global Variable    ${GLOBAL_BOOKING_ID}    ${None}
    Set Global Variable    ${GLOBAL_AUTH_TOKEN}    ${None}
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${None}

Tentar Excluir Reserva No Teardown
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    ${resultado}=    Run Keyword And Ignore Error    Realizar DELETE Request    /booking/${GLOBAL_BOOKING_ID}    ${headers}
    ${status_delete}=    Set Variable If    '${resultado[0]}' == 'PASS'    ${resultado[1].status_code}    N/A
    Log To Console    Teardown: Tentativa de excluir reserva ID ${GLOBAL_BOOKING_ID} resultou em status ${status_delete}

# --- Keywords de Operações de Teste de Nível Superior ---
Realizar Autenticacao E Armazenar Token
    ${credenciais}=    Gerar Credenciais De Autenticacao
    ${resp_auth}=    Realizar POST Request    /auth    ${credenciais}
    Validar Codigo De Resposta    ${resp_auth}    200
    ${token}=    Extrair Token Da Resposta    ${resp_auth}
    Set Global Variable    ${GLOBAL_AUTH_TOKEN}    ${token}
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_auth}

Criar Nova Reserva Completa
    [Arguments]    ${data_checkin}    ${data_checkout}
    ${payload}=    Criar Payload Para Nova Reserva    ${data_checkin}    ${data_checkout}
    ${resp_post}=    Realizar POST Request    /booking    ${payload}
    Validar Codigo De Resposta    ${resp_post}    200
    ${id_gerado}=    Extrair ID Da Reserva    ${resp_post}
    Set Global Variable    ${GLOBAL_BOOKING_ID}    ${id_gerado}
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_post}
    Log To Console    Reserva criada com ID: ${id_gerado}

Buscar Detalhes Da Reserva Por ID
    [Arguments]    ${id_reserva_para_buscar}
    ${resp_get_id}=    Realizar GET Request    /booking/${id_reserva_para_buscar}
    Validar Codigo De Resposta    ${resp_get_id}    200
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_get_id}
    Log To Console    Detalhes da reserva ${id_reserva_para_buscar}: ${resp_get_id.json()}

Atualizar Detalhes Da Reserva
    [Arguments]    ${id_para_atualizar}    ${novo_primeiro_nome}    ${novo_sobrenome}
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    ${datas_atualizacao}=    Create Dictionary    checkin=2024-07-01    checkout=2024-07-10
    &{payload_put}=    Create Dictionary
    ...    firstname=${novo_primeiro_nome}
    ...    lastname=${novo_sobrenome}
    ...    totalprice=200
    ...    depositpaid=False
    ...    bookingdates=${datas_atualizacao}
    ...    additionalneeds=late-checkout
    ${resp_put}=    Realizar PUT Request    /booking/${id_para_atualizar}    ${payload_put}    ${headers}
    Validar Codigo De Resposta    ${resp_put}    200
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_put}
    Log To Console    Reserva ID ${id_para_atualizar} atualizada para: ${resp_put.json()}

Atualizar Campo Especifico Da Reserva (PATCH)
    [Arguments]    ${id_para_atualizar}    ${campo_para_atualizar}    ${novo_valor}
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    ${payload_patch}=    Create Dictionary    ${campo_para_atualizar}=${novo_valor}
    ${resp_patch}=    Realizar PATCH Request    /booking/${id_para_atualizar}    ${payload_patch}    ${headers}
    Validar Codigo De Resposta    ${resp_patch}    200
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_patch}
    Log To Console    Reserva ID ${id_para_atualizar} atualizada (PATCH): ${resp_patch.json()}

Deletar Reserva Existente
    [Arguments]    ${id_para_deletar}
    ${headers}=    Criar Headers Com Token    ${GLOBAL_AUTH_TOKEN}
    ${resp_delete}=    Realizar DELETE Request    /booking/${id_para_deletar}    ${headers}
    Validar Codigo De Resposta    ${resp_delete}    201
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_delete}
    Log To Console    Reserva ID ${id_para_deletar} excluída com sucesso.

*** Test Cases ***
Cenario: Autenticacao E Obtencao De Token
    [Tags]    AUTH    Smoke
    Realizar Autenticacao E Armazenar Token

Cenario: Listar Todas As Reservas
    [Tags]    GET
    ${resp_list}=    Realizar GET Request    /booking
    Validar Codigo De Resposta    ${resp_list}    200
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_list}

Cenario: Buscar Reserva Por Nome E Sobrenome
    [Tags]    GET    Filtro
    Criar Nova Reserva Completa    2025-06-01    2025-06-05
    ${params}=    Create Dictionary    firstname=${PRIMEIRO_NOME_TESTE}    lastname=${SOBRENOME_TESTE}
    ${resp_filtro}=    Realizar GET Request    /booking    ${params}
    Validar Codigo De Resposta    ${resp_filtro}    200
    Should Not Be Empty    ${resp_filtro.json()}
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_filtro}

Cenario: Buscar Reserva Por Intervalo De Datas
    [Tags]    GET    Filtro
    Criar Nova Reserva Completa    2025-07-01    2025-07-10
    ${params}=    Create Dictionary    checkin=2025-07-01    checkout=2025-07-10
    ${resp_filtro}=    Realizar GET Request    /booking    ${params}
    Validar Codigo De Resposta    ${resp_filtro}    200
    Should Not Be Empty    ${resp_filtro.json()}!=${EMPTY}
    Set Global Variable    ${ULTIMA_RESPOSTA_HTTP}    ${resp_filtro}

Cenario: Criar E Consultar Nova Reserva Por ID
    [Tags]    POST    GET    CRUD
    Criar Nova Reserva Completa    2025-08-01    2025-08-05
    Buscar Detalhes Da Reserva Por ID    ${GLOBAL_BOOKING_ID}

Cenario: Atualizar Reserva Existente (PUT)
    [Tags]    PUT    CRUD
    Realizar Autenticacao E Armazenar Token
    Criar Nova Reserva Completa    2025-09-01    2025-09-10
    Atualizar Detalhes Da Reserva    ${GLOBAL_BOOKING_ID}    Jane    Doe

Cenario: Atualizar Parcialmente Reserva (PATCH)
    [Tags]    PATCH    CRUD
    Realizar Autenticacao E Armazenar Token
    Criar Nova Reserva Completa    2025-10-01    2025-10-05
    Atualizar Campo Especifico Da Reserva (PATCH)    ${GLOBAL_BOOKING_ID}    firstname    Johnathan

Cenario: Excluir Reserva E Validar Sucesso
    [Tags]    DELETE    CRUD
    Realizar Autenticacao E Armazenar Token
    Criar Nova Reserva Completa    2025-11-01    2025-11-07
    Deletar Reserva Existente    ${GLOBAL_BOOKING_ID}
