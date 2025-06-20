# Atividades – Estratégias de Mapeamento de Elementos HTML e Automação Web

## Objetivo

Este diretório reúne atividades práticas e teóricas da Semana 13, com foco em:

- Estratégias de mapeamento de elementos HTML
- Boas práticas de automação de testes (front-end e back-end)
- Integração de testes web com banco de dados e APIs
- Aplicação prática com Robot Framework + Node.js

As atividades foram organizadas em três núcleos: prática com DOMs reais, fundamentação teórica e automação integrada com o projeto **ServeRest**.

---

## Estrutura do Diretório

```
semana-13/
│
├── automação robot + node js/ ← Em andamento
│ ├── mark85-robot-express/ # Projeto com Robot Framework + Node.js
│ └── relatório de execução/ # Relatório consolidado
│
├── html elements mapping - theory/
│ └── Qualidade e Robustez de Seletores em Testes Automatizados Web.pdf
│
└── mapping strategies - pratice/
├── Mapeamento de Elementos - Demoblaze.pdf
├── Mapeamento de Elementos - The Internet (Squad).pdf
├── Mapeamento de Elementos HTML - Livelo.pdf
├── Mapeamento de Elementos HTML - Divvino.pdf
└── Mapeamento de Elementos HTML - Google.pdf
```

---
## Automação Back + Front – Mark85 (robot + node.js)

### 📁 mark85-robot-express

Projeto de automação baseado na aplicação de tarefas **Mark85**, com foco em:

- Arquitetura escalável com Page Objects, Components e Fixtures
- Testes de front-end (cadastro, login, CRUD de tarefas)
- Testes de back-end com `RequestsLibrary` para validações diretas via API
- Manipulação de banco de dados MongoDB com `pymongo` e `bcrypt`
- Geração de massa fixa reutilizável e limpa a cada execução
- Execução local da aplicação com controle de ambiente via terminal

### 📊 Relatório de Execução

- Integração prática entre teoria, boas práticas e ferramentas de automação
- Estratégias para garantir **independência de testes**, uso racional de massa de dados e criptografia de senha
- Adoção de testes visuais (CSS validation), screenshots automáticos em falhas, e suporte a execução paralela com `pabot`

> O uso da `FakerLibrary` foi inicialmente utilizado, mas descartado por gerar inflação de dados no banco em ambientes reais. Optou-se por massa fixa com controle automatizado, garantindo reprodutibilidade e sustentabilidade dos testes.

---

## Mapeamentos Práticos (mapping strategies - pratice)

Conjunto de estudos aplicados para explorar estratégias de seleção como:

- `id`, `class`, `name`, `aria-label`
- Operadores de atributo (`^=`, `$=`, `*=`), pseudo-classes (`:not`, `nth-child`)
- CSS hierárquico vs. XPath
- Atributos customizados (`onclick`, `data-*`)

### ✳Atividades incluídas:

#### 👥 Em Squad: [The Internet – Challenging DOM](https://the-internet.herokuapp.com/challenging_dom)

- **Cenário:** Botões com atributos dinâmicos e tabela estática
- **Aprendizados:** Confiabilidade de classes, uso de pseudo-classes, XPath vs CSS

#### 👤 Individual: [Demoblaze](https://www.demoblaze.com)

- **Desafio:** Aplicar 8 estratégias distintas em diferentes elementos
- **Abrangência:** Do `id` ao XPath textual, cobrindo campos, botões e menus

### Atividades Complementares

#### 🛍️ Livelo

- Mapeamento de botões principais da interface superior
- Uso intensivo de `id`, `aria-label` e `data-testid`

#### 🍷 Divvino

- Foco em categorias, produtos, botão de carrinho e ícone de busca
- Estratégias de array, seletores compostos e estrutura semântica

#### 🔍 Google

- Mapeamento da homepage e da página de resultados
- Destaque para atributos como `name`, `id`, `value`, `aria-label`


> Todas as atividades se encontram em "mapping strategies - pratice".

---

## Fundamentação Teórica (html elements mapping - theory)

### 📄 Qualidade e Robustez de Seletores em Testes Automatizados Web

Documento de referência que resume:

- Diferenças entre seletores frágeis e estáveis
- Estratégias preferenciais para testes duradouros
- Impactos de mudanças no front-end sobre scripts automatizados

---

## Resultados Gerais

- **Consolidação do conhecimento sobre estratégias de mapeamento**
- **Aplicação prática das estratégias em contextos reais**
- **Integração entre front-end, back-end e banco de dados**
- **Adoção de boas práticas de automação e arquitetura de testes**
- **Contato com ferramentas de mercado: Robot Framework, Node.js, MongoDB, Git, Playwright**

---

> Os conteúdos desta semana marcaram um passo importante no aprofundamento técnico da automação de testes, na análise crítica de seletores e na construção de automações reais, robustas e sustentáveis.
