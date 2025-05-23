*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    String

*** Variables ***
${url}    https://reqres.in/api
${urlLogin}    /login
${urlRegister}    /register
${urlListarUsuarios}    /users
${email}    eve.holt@reqres.in
${password}    cityslicka

*** Keywords ***
verificar o status code
    [Arguments]    ${statusCode}
    Should Be Equal As Strings    ${responseBody.status_code}    ${statusCode}

verificar que existe a chave
    [Arguments]    ${jsonPath}    ${chave}
    ${json}=    Evaluate    ${responseBody.json()}
    IF    "${jsonPath}" == "$"
        Dictionary Should Contain Key    ${json}    ${chave}
    ELSE
        ${sub_dict}=    Get From Dictionary    ${json}    ${jsonPath}
        Dictionary Should Contain Key    ${sub_dict}    ${chave}
    END

email e senha são válidos
    ${body}=    Create Dictionary    email=${email}    password=${password}
    Set Global Variable    ${body}

efetuar login
    ${responseBody}=    POST    ${url}${urlLogin}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    Log    Resposta: ${responseBody}

ausência de email e senha
    ${body}=    Create Dictionary    email=    password=
    Set Global Variable    ${body}

verificar a mensagem de erro
    [Arguments]    ${msgErro}
    ${json}=    Evaluate    ${responseBody.json()}
    Dictionary Should Contain Item    ${json}    error    ${msgErro}

email válido mas ausência de senha
    ${body}=    Create Dictionary    email=${email}    password=
    Set Global Variable    ${body}

ausência de email mas senha válida
    ${body}=    Create Dictionary    email=    password=${password}
    Set Global Variable    ${body}

email inválido e uma senha válida
    [Arguments]    ${emailInvalido}
    ${body}=    Create Dictionary    email=${emailInvalido}    password=${password}
    Set Global Variable    ${body}

email e senha válidos para cadastro
    ${body}=    Create Dictionary    email=${email}    password=${password}
    Set Global Variable    ${body}

efetuar cadastro
    ${responseBody}=    POST    ${url}${urlRegister}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    Log    Resposta: ${responseBody}

ausência de email e senha para cadastro
    ${body}=    Create Dictionary    email=    password=
    Set Global Variable    ${body}

email válido mas ausência de senha para cadastro
    ${body}=    Create Dictionary    email=eve.holt@reqres.com    password=
    Set Global Variable    ${body}

ausência de email mas senha válida para cadastro
    ${body}=    Create Dictionary    email=    password=teste123
    Set Global Variable    ${body}

verificar usuários cadastrados
    [Arguments]    ${page}    ${per_page}
    ${body}=    Create Dictionary    page=${page}    per_page=${per_page}
    Set Global Variable    ${body}

verificar id de um usuário
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${responseBody}=    POST    ${url}${urlRegister}    json=${body}    expected_status=anything
    Set Global Variable    ${responseBody}
    ${json}=    Evaluate    ${responseBody.json()}
    ${id}=    Get From Dictionary    ${json}    id
    Set Global Variable    ${id}

    ${responseBody}=    GET    ${url}/users/${id}    expected_status=anything
    Set Global Variable    ${responseBody}
    ${json}=    Evaluate    ${responseBody.json()}
    ${name}=    Get From Dictionary    ${json['data']}    first_name
    Set Global Variable    ${name}

deletar um usuário
    ${responseBody}=    DELETE    ${url}/users/${id}
    Set Global Variable    ${responseBody}
