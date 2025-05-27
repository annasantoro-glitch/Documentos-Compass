*** Settings ***
Documentation     Este arquivo contém as keywords de utilidade para interagir com a API Restful-booker.
Library           RequestsLibrary
Library           String
Library           Collections

*** Variables ***
${BASE_API_URL}       https://restful-booker.herokuapp.com
${DEFAULT_USERNAME}   admin
${DEFAULT_PASSWORD}   password123
${SESSION_ALIAS}      booking_api_session # Um nome diferente para a sessão

*** Keywords ***
# --- Keywords de Configuração e Utilitário ---
Inicializar Sessao HTTP
    [Arguments]    ${url}=${BASE_API_URL}    ${alias}=${SESSION_ALIAS}
    Create Session    ${alias}    ${url}

Encerrar Todas As Sessoes HTTP
    Delete All Sessions

Validar Codigo De Resposta
    [Arguments]    ${response_obj}    ${codigo_esperado}
    Should Be Equal As Strings    ${response_obj.status_code}    ${codigo_esperado}
    Log To Console    Status Code da Resposta: ${response_obj.status_code}

Extrair Token Da Resposta
    [Arguments]    ${response_obj}
    Dictionary Should Contain Key    ${response_obj.json()}    token
    ${token_extraido}=    Get From Dictionary    ${response_obj.json()}    token
    [Return]    ${token_extraido}

Extrair ID Da Reserva
    [Arguments]    ${response_obj}
    Dictionary Should Contain Key    ${response_obj.json()}    bookingid
    ${id_reserva_extraido}=    Get From Dictionary    ${response_obj.json()}    bookingid
    [Return]    ${id_reserva_extraido}

# --- Keywords de Operações HTTP ---
Realizar POST Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}=${None}
    ${resp}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    [Return]    ${resp}

Realizar GET Request
    [Arguments]    ${endpoint}    ${params}=${None}
    ${resp}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}    params=${params}
    [Return]    ${resp}

Realizar PUT Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}
    ${resp}=    PUT On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    [Return]    ${resp}

Realizar PATCH Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}
    ${resp}=    PATCH On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    [Return]    ${resp}

Realizar DELETE Request
    [Arguments]    ${endpoint}    ${headers}
    ${resp}=    DELETE On Session    ${SESSION_ALIAS}    ${endpoint}    headers=${headers}
    [Return]    ${resp}

# --- Keywords de Geração de Dados ---
Gerar Credenciais De Autenticacao
    ${auth_body}=    Create Dictionary    username=${DEFAULT_USERNAME}    password=${DEFAULT_PASSWORD}
    [Return]    ${auth_body}

Gerar Nomes Aleatorios Para Reserva
    ${primeiro_nome_aleatorio}=    Generate Random String    length=6    chars=[LETTERS]
    ${primeiro_nome_aleatorio}=    Convert To Title Case    ${primeiro_nome_aleatorio}
    ${ultimo_nome_aleatorio}=    Generate Random String    length=7    chars=[LETTERS]
    ${sobrenome_aleatorio}=    Convert To Title Case    ${sobrenome_aleatorio}
    Set Suite Variable    ${PRIMEIRO_NOME_TESTE}    ${primeiro_nome_aleatorio}
    Set Suite Variable    ${SOBRENOME_TESTE}    ${sobrenome_aleatorio}

Criar Payload Para Nova Reserva
    [Arguments]    ${checkin_date}    ${checkout_date}    ${price}=150    ${deposit}=True    ${needs}=Sauna
    ${datas_reserva}=    Create Dictionary    checkin=${checkin_date}    checkout=${checkout_date}
    &{payload_completo}=    Create Dictionary
    ...    firstname=${PRIMEIRO_NOME_TESTE}
    ...    lastname=${SOBRENOME_TESTE}
    ...    totalprice=${price}
    ...    depositpaid=${deposit}
    ...    bookingdates=${datas_reserva}
    ...    additionalneeds=${needs}
    [Return]    ${payload_completo}

Criar Headers Com Token
    [Arguments]    ${auth_token}
    ${headers_auth}=    Create Dictionary    Cookie=token=${auth_token}
    [Return]    ${headers_auth}
