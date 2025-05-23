from src.calculadora import Calculadora

def test_soma():
    calc = Calculadora()
    assert calc.soma(2,3) == 5

def test_subtracao():
    calc = Calculadora()
    assert calc.subtracao(6,3) == 3

def test_divisao():
    calc = Calculadora()
    assert calc.divisao(4,1) == 4

def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicacao(5,3) == 15

def test_potenciacao():
    calc = Calculadora()
    assert calc.potenciacao(2,3) == 8

def test_porcentagem():
    calc = Calculadora()
    assert calc.porcentagem(50,200) == 25