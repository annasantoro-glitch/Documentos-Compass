*** Settings ***
Documentation     Suite de testes para o endpoint /login.
Resource          ../resources/login_keywords.robot

Suite Setup       Criar Sessão API
Suite Teardown    Encerrar Sessão API

*** Test Cases ***

CT-015 - Login com credenciais válidas
    ${usuario}=    Criar Usuario Valido Para Login
    ${response}=    Realizar Login Valido    ${usuario.email}    ${usuario.senha}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    Login realizado com sucesso
    ${token}=    Extrair Campo Da Resposta    ${response}    authorization
    Set Test Variable    ${TOKEN_VALIDO}    ${token}

CT-016 - Login com usuário não cadastrado
    ${response}=    Realizar Login Valido    fakeuser@naoexiste.com    123456    401
    Logar Resposta    ${response}
    Validar Status Code    ${response}    401
    Should Contain    ${response.text}    Email e/ou senha inválidos

CT-017 - Login com senha inválida
    ${usuario}=    Criar Usuario Valido Para Login
    ${response}=    Realizar Login Valido    ${usuario.email}    senhaErrada123    401
    Logar Resposta    ${response}
    Validar Status Code    ${response}    401
    Should Contain    ${response.text}    Email e/ou senha inválidos

CT-018 - Login sem fornecer senha
    ${usuario}=    Criar Usuario Valido Para Login
    ${response}=    Login Sem Senha    ${usuario.email}    400
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    password é obrigatório

CT-019 - Login sem fornecer e-mail
    ${response}=    Login Sem Email    123456    400
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    email é obrigatório