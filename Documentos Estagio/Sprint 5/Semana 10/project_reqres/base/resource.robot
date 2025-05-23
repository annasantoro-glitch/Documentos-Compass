*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           String

*** Variables ***
${BASE_URL}       https://reqres.in/api
${LOGIN_PATH}     /login
${REGISTER_PATH}  /register
${USERS_PATH}     /users
${DEFAULT_EMAIL}  eve.holt@reqres.in
${DEFAULT_PASS}   cityslicka
${EMPTY}          # string vazia

*** Keywords ***

Verificar Status Code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}    msg=Status code diferente do esperado.

Verificar Chave no JSON
    [Arguments]    ${response}    ${json_path}=${EMPTY}    ${chave}
    ${json}=    To JSON    ${response.content}
    IF    '${json_path}' == '' or '${json_path}' == '$'
        Dictionary Should Contain Key    ${json}    ${chave}
    ELSE
        ${sub_dict}=    Get From Dictionary    ${json}    ${json_path}
        Dictionary Should Contain Key    ${sub_dict}    ${chave}
    END

Preparar Body Login
    [Arguments]    ${email}=${DEFAULT_EMAIL}    ${password}=${DEFAULT_PASS}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    [Return]    ${body}

Preparar Body Register
    [Arguments]    ${email}=${DEFAULT_EMAIL}    ${password}=${DEFAULT_PASS}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    [Return]    ${body}

Preparar Body Ausente
    [Arguments]    ${fields}
    ${body}=    Create Dictionary
    :FOR    ${field}    IN    @{fields}
    \    Set To Dictionary    ${body}    ${field}    ${EMPTY}
    [Return]    ${body}

Executar Login
    [Arguments]    ${body}
    ${response}=    POST    ${BASE_URL}${LOGIN_PATH}    json=${body}    expected_status=anything
    [Return]    ${response}

Executar Cadastro
    [Arguments]    ${body}
    ${response}=    POST    ${BASE_URL}${REGISTER_PATH}    json=${body}    expected_status=anything
    [Return]    ${response}

Verificar Mensagem de Erro
    [Arguments]    ${response}    ${msg_erro}
    ${json}=    To JSON    ${response.content}
    Dictionary Should Contain Key    ${json}    error
    ${error}=    Get From Dictionary    ${json}    error
    Should Be Equal As Strings    ${error}    ${msg_erro}

Buscar Usuários
    [Arguments]    ${page}=1    ${per_page}=6
    ${response}=    GET    ${BASE_URL}${USERS_PATH}?page=${page}&per_page=${per_page}    expected_status=anything
    [Return]    ${response}

Registrar E Buscar ID do Usuário
    [Arguments]    ${email}=${DEFAULT_EMAIL}    ${password}=${DEFAULT_PASS}
    ${body}=    Preparar Body Register    ${email}    ${password}
    ${response}=    Executar Cadastro    ${body}
    ${json}=    To JSON    ${response.content}
    Dictionary Should Contain Key    ${json}    id
    ${user_id}=    Get From Dictionary    ${json}    id
    [Return]    ${user_id}

Buscar Usuário Por ID
    [Arguments]    ${user_id}
    ${response}=    GET    ${BASE_URL}${USERS_PATH}/${user_id}    expected_status=anything
    [Return]    ${response}

Deletar Usuário Por ID
    [Arguments]    ${user_id}
    ${response}=    DELETE    ${BASE_URL}${USERS_PATH}/${user_id}    expected_status=anything
    [Return]    ${response}
