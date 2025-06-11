*** Settings ***
Documentation    Arquivo base com variáveis, keywords e funções utilitárias usadas no endpoint login.    
Resource         ../resources/base.robot
Resource         ../resources/users_keywords.robot

*** Variables ***
${ENDPOINT_LOGIN}     /login

*** Keywords ***

Criar Sessao Login
    Criar Sessão API

Encerrar Sessao Login
    Encerrar Sessão API

Criar Usuario Valido Para Login
    Criar Sessão API
    ${nome}=    FakerLibrary.Name
    ${email}=   FakerLibrary.Email
    ${senha}=   Generate Random String    6    [NUMBERS]
    ${body}=    Create Dictionary    nome=${nome}    email=${email}    password=${senha}    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${body}    expected_status=201
    ${id}=    Extrair Campo Da Resposta    ${response}    _id
    &{usuario}=    Create Dictionary    id=${id}    email=${email}    senha=${senha}
    RETURN    ${usuario}

Realizar Login Valido
    [Arguments]    ${email}    ${senha}    ${status_esperado}=200
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    ${ENDPOINT_LOGIN}    json=${body}    expected_status=${status_esperado}
    RETURN    ${response}

Login Sem Senha
    [Arguments]    ${email}    ${status_esperado}=400
    ${body}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    serverest    ${ENDPOINT_LOGIN}    json=${body}    expected_status=${status_esperado}
    RETURN    ${response}

Login Sem Email
    [Arguments]    ${senha}    ${status_esperado}=400
    ${body}=    Create Dictionary    password=${senha}
    ${response}=    POST On Session    serverest    ${ENDPOINT_LOGIN}    json=${body}    expected_status=${status_esperado}
    RETURN    ${response}