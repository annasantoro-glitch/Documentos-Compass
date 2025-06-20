# Atividades – Estratégias de Mapeamento de Elementos HTML e Automação Web

## Objetivo

Este diretório reúne atividades práticas e teóricas da Semana 13, com foco em:

- Estratégias de mapeamento de elementos HTML
- Boas práticas de automação de testes (front-end e back-end)
- Análise crítica e aplicação prática com Robot Framework + Node.js

As atividades foram organizadas em três núcleos: prática com DOMs reais, fundamentação teórica e automação integrada com o projeto **ServeRest**.

---

## Estrutura do Diretório

```
semana-13/
│
├── automação robot + node js/ ← Em andamento
│ ├── mark85-robot-express/ # Projeto com Robot Framework + Node.js
│ └── relatório de execução/ # Relatório
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

## Automação Back + Front – ServeRest (robot + node.js)

### 📁 mark85-robot-express

- Projeto de automação da aplicação [ServeRest](https://github.com/PauloGoncalvesBH/ServeRest)
- Arquitetura baseada em boas práticas (POM, modularidade, logs)
- Integração com Node.js para simular backend e fluxos via API

### 📊 Relatório de Execução (em breve)

- Métricas dos testes
- Avaliação dos seletores utilizados
- Robustez e cobertura dos testes implementados

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
- **Integração entre teoria, prática e automação real**
- **Contato com ferramentas de mercado (Robot, Node.js, Mark85)**

---

> Os conteúdos desta semana marcaram um passo importante no aprofundamento da base técnica para automação de testes front-end e back-end, na análise crítica de seletores e na construção de automações mais robustas e sustentáveis.
