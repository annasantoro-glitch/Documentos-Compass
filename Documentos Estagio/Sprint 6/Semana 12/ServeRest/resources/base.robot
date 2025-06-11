*** Settings ***
Documentation     Arquivo base com bibliotecas, variáveis globais e funções utilitárias reutilizáveis em todas as suítes.
Library           RequestsLibrary
Library           String
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           FakerLibrary
Library           JSONLibrary
Library           warnings

*** Variables ***
${BASE_URL}       https://compassuol.serverest.dev
${TIMEOUT}        10

*** Keywords ***
Criar Sessão API
    ${warnings}=    Evaluate    warnings
    ${warnings.filterwarnings}=    Set Variable    ignore
    Create Session    serverest    ${BASE_URL}    timeout=${TIMEOUT}    verify=${False}

Encerrar Sessão API
    Delete All Sessions

Gerar Email Unico
    ${random}=    Generate Random String    5    [LOWER]
    RETURN    usuario_${random}@valido.com

Logar Resposta
    [Arguments]    ${response}
    Log To Console    === RESPOSTA DA API ===
    Log To Console    Status: ${response.status_code}
    Log To Console    Body: ${response.text}
    Log To Console    ======================
    
Validar Status Code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}

Criar Headers Autenticacao
    [Arguments]    ${token}=None
    ${headers}=    Create Dictionary    Content-Type=application/json
    IF    "${token}" != "None" and "${token}" != ""    Set To Dictionary    ${headers}    Authorization=Bearer ${token}
    RETURN    ${headers}

Extrair Campo Da Resposta
    [Arguments]    ${response}    ${campo}
    ${json}=    Evaluate    json.loads('''${response.text}''')    json
    RETURN    ${json}[${campo}]

Imprimir Resposta Formatada
    [Arguments]    ${response}
    Log To Console    ${response.status_code}
    Log To Console    ${response.text}