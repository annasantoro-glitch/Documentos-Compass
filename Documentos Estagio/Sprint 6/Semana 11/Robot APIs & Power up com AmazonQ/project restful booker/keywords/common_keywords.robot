*** Settings ***
Documentation     Arquivo com as Keywords de utilidade geral para interagir com a API.
Library           RequestsLibrary
Library           JSONLibrary    
Library           String
Library           Collections 

*** Variables ***
${SESSION_ALIAS}      booking_api_session

*** Keywords ***
# --- Keywords de Configuração e Utilitário ---
Carregar Dados Do Arquivo JSON
    [Arguments]    ${file_path}
    ${json_data}=    Load JSON From File    ${file_path}
    RETURN    ${json_data}

Inicializar Sessao HTTP
    [Arguments]    ${url}    ${alias}=${SESSION_ALIAS}
    Create Session    ${alias}    ${url}

Encerrar Todas As Sessoes HTTP
    Delete All Sessions

Validar Codigo De Resposta
    [Arguments]    ${response_obj}    ${codigo_esperado}
    Should Be Equal As Strings    ${response_obj.status_code}    ${codigo_esperado}
    Log To Console    Status Code da Resposta: ${response_obj.status_code}

Extrair Valor Do JSON
    [Arguments]    ${json_obj}    ${key}
    Dictionary Should Contain Key    ${json_obj}    ${key}
    ${valor_extraido}=    Get From Dictionary    ${json_obj}    ${key}
    RETURN    ${valor_extraido}

# --- Keywords de Operações HTTP ---
Realizar POST Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}=${None}
    ${resp}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    RETURN    ${resp}

Realizar GET Request
    [Arguments]    ${endpoint}    ${params}=${None}
    ${resp}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}    params=${params}
    RETURN    ${resp}

Realizar PUT Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}
    ${resp}=    PUT On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    RETURN    ${resp}

Realizar PATCH Request
    [Arguments]    ${endpoint}    ${payload}    ${headers}
    ${resp}=    PATCH On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${headers}
    RETURN    ${resp}

Realizar DELETE Request
    [Arguments]    ${endpoint}    ${headers}
    ${resp}=    DELETE On Session    ${SESSION_ALIAS}    ${endpoint}    headers=${headers}
    RETURN    ${resp}

# --- Keywords de Geração de Dados Genéricas ---
Gerar Nomes Aleatorios Para Reserva
    ${primeiro_nome_aleatorio}=    Generate Random String    length=6    chars=[LETTERS]
    ${primeiro_nome_aleatorio}=    Convert To Title Case    ${primeiro_nome_aleatorio}
    ${sobrenome_aleatorio}=    Generate Random String    length=7    chars=[LETTERS]
    ${sobrenome_aleatorio}=    Convert To Title Case    ${sobrenome_aleatorio}
    Set Suite Variable    ${PRIMEIRO_NOME_TESTE}    ${primeiro_nome_aleatorio}
    Set Suite Variable    ${SOBRENOME_TESTE}    ${sobrenome_aleatorio}