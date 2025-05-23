class Calculadora:
    def soma(self, a, b):
        return a + b

    def subtracao(self, a, b):
        return a - b

    def divisao(self, a, b):
        if b == 0:
            raise ValueError("Não é possível dividir por zero")
        return a / b

    def multiplicacao(self, a, b):
        return a * b

    def potenciacao(self, a, b):
        return a ** b

    def porcentagem(self, a, b):
        return (a / b) * 100