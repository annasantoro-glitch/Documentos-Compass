*** Settings ***
Documentation    Arquivo base com variáveis, keywords e funções utilitárias usadas no endpoint usuários.
Resource         ../resources/base.robot

*** Variables ***
${USER_ENDPOINT}  /usuarios

*** Keywords ***

Criar Novo Usuário Valido
    ${random}=    Evaluate    random.randint(10000, 99999)    modules=random
    ${email}=     Set Variable    joao${random}@valido.com
    ${payload}=   Create Dictionary    nome=João Silva    email=${email}    password=123456    administrador=true
    Create Session    serverest    ${BASE_URL}
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=201
    Dictionary Should Contain Key    ${response.json()}    _id
    Set Suite Variable    ${USER_ID}    ${response.json()}[_id]
    Set Suite Variable    ${USER_EMAIL}    ${email}
    RETURN    ${response}

Criar Usuário Com Email Existente
    ${random}=    Evaluate    random.randint(10000, 99999)    modules=random
    ${email}=     Set Variable    duplicado${random}@teste.com
    ${payload}=   Create Dictionary    nome=Usuário Original    email=${email}    password=123456    administrador=true
    Create Session    serverest    ${BASE_URL}
    POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=201
    ${payload_dup}=   Create Dictionary    nome=Usuário Duplicado    email=${email}    password=123456    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload_dup}    expected_status=400
    RETURN    ${response}

Criar Usuário Com Email Invalido
    ${payload}=   Create Dictionary    nome=Usuário Inválido    email=joao@val*d.com    password=123456    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Criar Usuario Com Dominio Gmail
    ${payload}=   Create Dictionary    nome=João Silva    email=joao@gmail.com    password=123456    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}    

Criar Usuario Com Senha Curta
    ${random}=    Evaluate    random.randint(10000, 99999)    modules=random
    ${payload}=   Create Dictionary    nome=Usuario Fraco    email=senha${random}@teste.com    password=123    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Criar Usuario Com Senha Longa
    ${random}=    Evaluate    random.randint(10000, 99999)    modules=random
    ${payload}=   Create Dictionary    nome=Usuario Forte    email=senhalonga${random}@teste.com    password=12345678910    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Buscar Usuario Por ID Invalido
    ${response}=  GET On Session    serverest    ${USER_ENDPOINT}/id_inexistente    expected_status=400
    RETURN    ${response}

Excluir Usuario Inexistente
    ${response}=  DELETE On Session    serverest    ${USER_ENDPOINT}/id_inexistente
    RETURN    ${response}

Buscar Todos Usuarios
    ${response}=  GET On Session    serverest    ${USER_ENDPOINT}
    RETURN    ${response}

Criar Usuario Sem Email
    ${payload}=   Create Dictionary    nome=Teste    password=123456    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Criar Usuario Com Administrador Invalido
    ${email}=    Gerar Email Unico
    ${payload}=   Create Dictionary    nome=João Silva    email=${email}    password=123456    administrador=talvez
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Criar Usuario Com Nome Vazio
    ${email}=    Gerar Email Unico
    ${payload}=   Create Dictionary    nome=    email=${email}    password=123456    administrador=true
    ${response}=  POST On Session    serverest    ${USER_ENDPOINT}    json=${payload}    expected_status=400
    RETURN    ${response}

Editar Usuario Com Email Duplicado
    [Arguments]    ${id}
    ${payload}=   Create Dictionary    nome=User 2    email=${USER_EMAIL}    password=123456    administrador=true
    ${response}=  PUT On Session    serverest    ${USER_ENDPOINT}/${id}    json=${payload}    expected_status=400
    RETURN    ${response}
