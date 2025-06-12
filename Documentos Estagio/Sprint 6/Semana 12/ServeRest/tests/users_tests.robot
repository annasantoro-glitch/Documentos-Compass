*** Settings ***
Documentation     Suite de testes para o endpoint /produtos, envolvendo cenários de cadastro, listagem, alteração, verificação e exclusão de usuários.
Resource          ../resources/users_keywords.robot

Suite Setup       Criar Sessão API
Suite Teardown    Encerrar Sessão API

*** Test Cases ***

CT-001 - Cadastro válido de novo usuário
    ${response}=    Criar Novo Usuário Valido
    Logar Resposta    ${response}
    Validar Status Code    ${response}    201
    Should Contain    ${response.text}    Cadastro realizado com sucesso
    ${id}=    Extrair Campo Da Resposta    ${response}    _id
    Set Suite Variable    ${ID_CADASTRADO}    ${id}

CT-002 - Cadastro com e-mail duplicado
    ${response}=    Criar Usuário Com Email Existente
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    Este email já está sendo usado

CT-003 - Cadastro com e-mail inválido
    ${response}=    Criar Usuário Com Email Invalido
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    email deve ser um email válido

CT-004 - Cadastro com domínio restrito (gmail)
    ${response}=    Criar Usuario Com Dominio Gmail
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    O domínio do e-mail informado não é permitido.

CT-005 - Cadastro com senha curta
    ${response}=    Criar Usuario Com Senha Curta
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    senha deve conter entre 5 e 10 caracteres

CT-006 - Cadastro com senha longa demais
    ${response}=    Criar Usuario Com Senha Longa
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    senha deve conter entre 5 e 10 caracteres

CT-007 - GET com ID inexistente
    ${response}=    Buscar Usuario Por ID Invalido
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    id deve ter exatamente 16 caracteres alfanuméricos

CT-009 - PUT em usuário com e-mail duplicado
    # Criar primeiro usuário
    ${response1}=    Criar Novo Usuário Valido
    Logar Resposta    ${response1}
    ${id1}=    Extrair Campo Da Resposta    ${response1}    _id
    
    # Criar segundo usuário
    ${response2}=    Criar Novo Usuário Valido
    Logar Resposta    ${response2}
    ${id2}=    Extrair Campo Da Resposta    ${response2}    _id
    
    # Tentar editar o segundo usuário com o email do primeiro
    ${response}=    Editar Usuario Com Email Duplicado    ${id2}
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    Este email já está sendo usado

CT-010 - DELETE de usuário inexistente
    ${response}=    Excluir Usuario Inexistente
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain Any    ${response.text}    Nenhum registro excluído    Usuário não encontrado

CT-011 - GET todos os usuários
    ${response}=    Buscar Todos Usuarios
    Logar Resposta    ${response}
    Validar Status Code    ${response}    200
    Should Contain    ${response.text}    nome
    Should Contain    ${response.text}    email

CT-012 - Verificar campo obrigatório ausente (email)
    ${response}=    Criar Usuario Sem Email
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    email é obrigatório

CT-013 - Campo "administrador" inválido
    ${response}=    Criar Usuario Com Administrador Invalido
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    administrador deve ser 'true' ou 'false'

CT-014 - Nome vazio
    ${response}=    Criar Usuario Com Nome Vazio
    Logar Resposta    ${response}
    Validar Status Code    ${response}    400
    Should Contain    ${response.text}    nome não pode ficar em branco
