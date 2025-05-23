*** Settings ***
Resource    ../base/resource.robot
Library     RequestsLibrary

# Feature: DELETE - Deletar Usuário

*** Test Cases ***
Cenário 01: Deletar Usuário Sucesso
    [Tags]    DeleteUser
    Given verificar id de um usuário
    When deletar um usuário
    Then verificar o status code    204