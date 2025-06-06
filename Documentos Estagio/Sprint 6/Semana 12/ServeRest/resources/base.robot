*** Settings ***
Documentation     Arquivo base com bibliotecas, variáveis globais e funções utilitárias reutilizáveis em todas as suítes.
Library           RequestsLibrary
Library           String
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           FakerLibrary
Library           JSONLibrary

*** Variables ***
${BASE_URL}       https://serverest.dev
${TIMEOUT}        5

*** Keywords ***
Criar Sessão API
    Create Session    serverest    ${BASE_URL}    timeout=${TIMEOUT}

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

Extrair Campo Da Resposta
    [Arguments]    ${response}    ${campo}
    ${json}=    Evaluate    json.loads('''${response.text}''')    json
    RETURN    ${json}[${campo}]

Imprimir Resposta Formatada
    [Arguments]    ${response}
    Log To Console    ${response.status_code}
    Log To Console    ${response.text}