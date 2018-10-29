import spells.*

class CotaDeMallas {
	const unidadesDeLucha 
	constructor(unidadesDeLuchaIni){
		unidadesDeLucha = unidadesDeLuchaIni
	}
	method peso() = 1
	method valor(duenio) = unidadesDeLucha
	method monedas(valorBaseArmadura) = unidadesDeLucha / 2 
}

object bendicion {
	method peso() = 0
	method valor(duenio) = duenio.nivelDeHechiceria()
	method monedas(valorBaseArmadura) = valorBaseArmadura
}

class Hechizo{
	var property spell
	constructor (spellInicial){
		spell = spellInicial
	}
	method peso(){
		if(spell.poder().even()){
			return 2
		}
		return 1
	}
	method valor(duenio) = spell.poder()
	method monedas(valorBaseArmadura) = valorBaseArmadura + spell.monedas()
}
object ninguno{
	method peso() = 0
	method valor(duenio) = 0
	method monedas(valorBaseArmadura) = 2
}