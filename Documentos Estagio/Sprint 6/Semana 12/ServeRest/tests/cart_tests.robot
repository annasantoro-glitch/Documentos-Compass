*** Settings ***
Documentation    Testes do endpoint /carrinhos com diferentes cenários de criação, cancelamento e acesso.
Resource         ../resources/cart_keywords.robot

*** Test Cases ***
CT-033 - Criar carrinho com produto válido e quantidade adequada
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${produto}=    Criar Produto Valido
    ${carrinho}=    Criar Carrinho Com Produto    ${token}    ${produto._id}    2
    Should Be Equal As Strings    ${carrinho.message}    Cadastro realizado com sucesso
    Should Not Be Empty    ${carrinho._id}

CT-034 - Criar carrinho com quantidade zero
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${produto}=    Criar Produto Valido
    ${resposta}=    Criar Carrinho Com Produto    ${token}    ${produto._id}    0    expected_status=400
    Should Contain    ${resposta.message}    quantidade

CT-035 - Criar carrinho com quantidade acima do estoque
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${produto}=    Criar Produto Com Estoque Limitado    5
    ${resposta}=    Criar Carrinho Com Produto    ${token}    ${produto._id}    9999    expected_status=400
    Should Contain    ${resposta.message}    estoque

CT-036 - Criar carrinho com produto inexistente
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${resposta}=    Criar Carrinho Com Produto    ${token}    idinvalido123    1    expected_status=400
    Should Contain    ${resposta.message}    produto

CT-037 - Deletar carrinho existente
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${produto}=    Criar Produto Valido
    ${carrinho}=    Criar Carrinho Com Produto    ${token}    ${produto._id}    1
    ${resposta}=    Deletar Carrinho    ${token}
    Should Be Equal As Strings    ${resposta.message}    Registro excluído com sucesso

CT-038 - Cancelar compra e devolver ao estoque
    ${usuario}=    Criar Usuario Valido Para Login
    ${token}=    Gerar Token Autenticado    ${usuario.email}    ${usuario.senha}
    ${produto}=    Criar Produto Valido
    ${carrinho}=    Criar Carrinho Com Produto    ${token}    ${produto._id}    1
    ${resposta}=    Cancelar Compra Carrinho    ${token}
    Should Be Equal As Strings    ${resposta.message}    Registro excluído com sucesso. Estoque dos produtos restaurado

CT-039 - Criar carrinho sem autenticação
    ${produto}=    Criar Produto Valido
    ${resposta}=    Criar Carrinho Sem Autenticacao    ${produto._id}    1    expected_status=401
    Should Contain    ${resposta.message}    Token de acesso ausente ou inválido