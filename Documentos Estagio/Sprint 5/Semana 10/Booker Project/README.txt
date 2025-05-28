Projeto de Automação - API Restful Booker
([https://restful-booker.herokuapp.com/](https://restful-booker.herokuapp.com/))

Este projeto contém a automação de testes para a API Restful Booker, desenvolvido utilizando Robot Framework no Visual Studio Code (VSCode). Durante o desenvolvimento, foram utilizadas as bibliotecas Collections, String e Requests para a construção dos testes.

Objetivo:
O principal objetivo deste projeto é praticar e consolidar o conhecimento em testes de APIs RESTful, aplicando boas práticas como:

* Estrutura modular de pastas.
* Criação de keywords reutilizáveis.
* Validação de status code e payloads das respostas.
* Manipulação e persistência de dados entre as requisições.

Desafios e Aprendizados:
Este projeto foi muito mais do que uma simples automação. Foi um verdadeiro exercício de adaptação e superação: precisei reconstruir o projeto mais de sete vezes, revisando cada detalhe, ajustando estratégias e refinando o código. A cada obstáculo, foi necessário reavaliar abordagens, entender melhor o comportamento da API e encontrar soluções criativas para problemas que surgiam. Foi desafiador, mas extremamente enriquecedor.

Code Review:
Além da automação própria, o repositório inclui um Code Review do projeto de automação de um colega, também utilizando a API Restful Booker. O objetivo do review é analisar a qualidade do código, aplicando critérios de boas práticas, legibilidade, organização e clareza nos testes.

Tecnologias Utilizadas:

* Robot Framework
* Requests Library
* Visual Studio Code

Como executar este projeto:

1. Certifique-se de ter o Python instalado em sua máquina.
2. Instale o Robot Framework e a biblioteca Requests com os seguintes comandos:
   pip install robotframework
   pip install robotframework-requests
3. Clone este repositório em sua máquina.
4. Navegue até o diretório raiz do projeto.
5. Execute os testes utilizando o comando:
   robot nome_do_arquivo.robot
   (substitua "nome_do_arquivo.robot" pelo arquivo ou diretório que deseja executar).
6. Para visualizar o relatório gerado, abra o arquivo "report.html" na raiz do projeto.

Observação:
Este projeto foi desenvolvido com foco em aprendizado e prática de automação de testes de APIs RESTful. Feedbacks são bem-vindos!

