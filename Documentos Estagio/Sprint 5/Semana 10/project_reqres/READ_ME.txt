PROJETO DE TESTES AUTOMATIZADOS DA API REQRES

Descrição

Este projeto contém testes automatizados para a API pública ReqRes (https://reqres.in), utilizando Robot Framework. O objetivo é validar os principais endpoints, com foco em registro, login, recursos e usuários, garantindo a conformidade funcional e identificando possíveis inconsistências na documentação oficial.

Observação Importante

Durante a automação do endpoint /register, foi identificado que a documentação Swagger apresenta o campo "username" no corpo da requisição:

{
"username": "string",
"email": "string",
"password": "string"
}

Porém, os testes mostram que a API não utiliza nem valida o campo "username". A requisição é considerada válida e bem-sucedida apenas com os campos "email" e "password".

Data dos testes: 22/05/2025

Ferramentas utilizadas: Robot Framework, VSCode

Estrutura do projeto

keywords/: arquivos contendo as keywords para cada endpoint (register, login, resource, users) e keywords comuns.

tests.robot: arquivo principal contendo os casos de teste.

variables.robot (opcional): variáveis globais do projeto.

Como executar os testes

1 - Instale o Robot Framework e a biblioteca RequestsLibrary.

2 - Configure o ambiente Python.

3 - Execute o comando:

4 - robot tests.robot