*** Settings ***
Resource    ../base/resource.robot
Library    RequestsLibrary

# Sessão Login

*** Test Cases ***
Cenário 01: Login Sucesso
    [Tags]    Login
    Given email e senha são válidos
    When efetuar login
    Then verificar o status code    200
    And verificar que existe a chave    ${chave}

Cenário 02: Login Ausência de Campos Obrigatórios
    [Tags]    Login
    Given ausência de email e senha
    When efetuar login
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing email or username

Cenário 03: Login Campo Email Obrigatório
    [Tags]    Login
    Given email válido mas ausência de senha
    When efetuar login
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing password

Cenário 04: Login Campo Senha Obrigatório
    [Tags]    Login
    Given ausência de email mas senha válida
    When efetuar login
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing email or username

Cenário 05: Login Usuário Inexistente
    [Tags]    Login
    Given email inválido e uma senha válida    naoExiste@naoExiste.com
    When efetuar login
    Then verificar o status code    400
    And verificar a mensagem de erro    user not found

# Sessão Cadastro de Usuário   

Cenário 06: Registrar Usuário Sucesso
    [Tags]    Register
    Given email e senha válidos para cadastro
    When efetuar cadastro
    Then verificar o status code    200
    And verificar que existe a chave    $    id
    And verificar que existe a chave    $    token

Cenário 08: Registrar Ausência de Campos Obrigatório
    [Tags]    Register
    Given ausência de email e senha para cadastro
    When efetuar cadastro
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing email or username

Cenário 09: RegistrarCampo Senha Obrigatório
    [Tags]    Register
    Given email válido mas ausência de senha para cadastro
    When efetuar cadastro
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing password

Cenário 10: Registrar Campo Email Obrigatório
    [Tags]    Register
    Given ausência de email mas senha válida para cadastro
    When efetuar cadastro
    Then verificar o status code    400
    And verificar que existe a chave    $    error
    And verificar a mensagem de erro    Missing email or username