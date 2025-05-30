*** Settings ***
Documentation     Arquivo com as Keywords específicas para o endpoint de autenticação.
Resource          ../common_keywords.robot

*** Keywords ***
# --- Keywords do Endpoint /auth ---
Gerar Credenciais De Autenticacao
    [Arguments]    ${username}    ${password}
    ${auth_body}=    Create Dictionary    username=${username}    password=${password}
    RETURN    ${auth_body}

Realizar Autenticacao E Retornar Token
    [Arguments]    ${username}    ${password}
    ${credenciais}=    Gerar Credenciais De Autenticacao    ${username}    ${password}
    ${resp_auth}=    Realizar POST Request    /auth    ${credenciais}
    Validar Codigo De Resposta    ${resp_auth}    200
    ${token}=    Extrair Valor Do JSON    ${resp_auth.json()}    token
    RETURN    ${token}

Criar Headers Com Token
    [Arguments]    ${auth_token}
    ${headers_auth}=    Create Dictionary    Cookie=token=${auth_token}
    RETURN    ${headers_auth}