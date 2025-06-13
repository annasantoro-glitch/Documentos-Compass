# Atividades – Estratégias de Mapeamento de Elementos HTML

## Objetivo

Estas atividades tiveram como objetivo **explorar e aplicar diferentes estratégias de mapeamento de elementos HTML**, tanto em equipe quanto de forma individual, com foco na automação de testes web. Através de cenários práticos, buscou-se compreender **qual a melhor forma de localizar elementos com precisão, estabilidade e manutenibilidade**, em páginas com diferentes estruturas e desafios.

---

## Atividade em Squad

### Contexto

- **Site analisado:** [Challenging DOM – The Internet](https://the-internet.herokuapp.com/challenging_dom)
- **Cenário:** A página apresenta três botões com atributos dinâmicos e uma tabela com células estáticas. O desafio era mapear esses elementos com seletores confiáveis, apesar das variações constantes em atributos como `id` e `text`.

---

### O que foi feito

#### Estratégias estudadas:
- Seletor por **classe (`class`)**
- **XPath**
- **Pseudo-classes CSS** (`nth-child`)
- Avaliação de fragilidade em atributos dinâmicos

#### Elementos mapeados:

1. **Botão principal (`foo`)**
2. **Botão de alerta (`bar`)**
3. **Botão de sucesso (sem texto)**
4. **Primeira célula da tabela**

#### Observações importantes:
- Classes fixas foram as mais confiáveis para botões com IDs dinâmicos.
- Para elementos sem classe ou ID, **pseudo-classes como `nth-child`** se mostraram úteis, apesar de mais frágeis em mudanças estruturais.

---

## Atividade Individual

### Contexto

- **Site escolhido:** [Demoblaze](https://www.demoblaze.com)
- **Objetivo:** Aplicar **8 estratégias distintas de mapeamento**, cada uma em um elemento diferente da interface.

---

### O que foi feito

#### Estratégias utilizadas:
- ID único
- Atributo customizado (`onclick`)
- Fallback com `id` em vez de `name`
- Class name
- CSS avançado (descendant)
- Operadores de atributo (`^=`)
- Pseudo-classe `:not`
- XPath baseado em texto

#### Elementos mapeados:

1. **Modal de Login**
2. **Botão “Log in” no modal**
3. **Campo username**
4. **Link “Log in” do menu**
5. **Categoria “Phones”**
6. **Campo de login (dinâmico)**
7. **Campos de input visíveis**
8. **Botão “Log in” (por texto)**

---

## Resultados e aprendizados

### Principais aprendizados:

- Desenvolvimento de **visão crítica** para escolher a melhor estratégia de acordo com o contexto do DOM.
- **XPath e seletores CSS** possuem forças complementares: XPath é poderoso em hierarquias complexas, e CSS é mais legível e direto.
- O mapeamento reforçou a importância da **manutenibilidade dos testes**, especialmente em aplicações com UI dinâmica.
- Na atividade em Squad, a troca entre membros trouxe novas ideias e validou boas práticas.
- Na atividade individual, houve espaço para **experimentação com diferentes estruturas e refinamento das decisões técnicas**.

---

> Esta atividade foi essencial para consolidar o domínio prático de mapeamento de elementos HTML, habilidade chave para automação de testes robusta e sustentável.
