*** Settings ***
Documentation     Testes automatizados para autenticação e validade do token JWT.
Library           RequestsLibrary
Resource          ../resources/auth_keywords.robot
Suite Setup       Criar Sessao Login
Suite Teardown    Encerrar Sessao Login

*** Test Cases ***

CT-020 - Validade do token (10 minutos)
    ${token}=      Obter Token Válido
    # Simulando expiração de token (delay de 10s por enquanto)
    Sleep             60s
    ${resposta}=      Acessar Endpoint Protegido Com Token    ${token}    ${ENDPOINT_PROTEGIDO}    200
    Logar Resposta    ${resposta}

CT-021 - Reutilização de token após logout ou expiração
    ${resposta}=    Token Expirado Ou Invalido
    Logar Resposta    ${resposta}
    Validar Status Code    ${resposta}    401
    Should Contain Any    ${resposta.text}    token expirado    inválido    Unauthorized
