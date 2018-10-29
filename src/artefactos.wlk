import efectosGlobales.*
import refuerzos.*

class Artefacto{
	var pesoBase
	var fechaCompra
	constructor (unPesoBase,unFechaCompra){
		pesoBase = unPesoBase
		fechaCompra = unFechaCompra
	}
	method factorDeCorreccion() = 1.min((fechaActual.fecha()-fechaCompra)/100)
	method pesoTotal(duenio) = pesoBase - self.factorDeCorreccion()
	method unidadesDeLucha(duenio)
	method monedas()
}

class Arma inherits Artefacto {
	override method unidadesDeLucha(duenio) = 3
	override method monedas() = 5 * pesoBase
}

class CollarDivino inherits Artefacto{
	var property perlas 
	constructor (unPerlas,unPesoBase,unFechaCompra) = 
		super(unPesoBase,unFechaCompra){
			perlas = unPerlas
		}
	override method pesoTotal(duenio) = super(duenio) + perlas/2
	override method unidadesDeLucha(duenio) = perlas
	override method monedas() = 2 * perlas
}

class MascaraOscura inherits Artefacto {
	const indiceDeOscuridad
	var property valorMinimo = 4
	constructor(indiceDeOscuridadInt,unPesoBase,unFechaCompra) =
		super(unPesoBase,unFechaCompra){
			indiceDeOscuridad = indiceDeOscuridadInt
		}
	method esOscura() = indiceDeOscuridad > 0
	override method pesoTotal(duenio){
		if(self.esOscura()){
			return super(duenio) + 3.max(self.unidadesDeLucha(duenio)) - 3
		}
		return super(duenio)
	} // asumimos que una mascara es clara cuando su indice de oscuridad es 0, y que sino es oscura
	override method unidadesDeLucha(duenio) = valorMinimo.max((fuerzaOscura.valor()/2)*indiceDeOscuridad)
	override method monedas() = 10 * indiceDeOscuridad //No se especifica el precio, lo tratamos como arma
}

class Armadura inherits Artefacto {
	var property refuerzo
	const valorBaseArmadura
	constructor(refuerzoIni,valorBaseArmaduraIni,unPesoBase,unFechaCompra) =
		super(unPesoBase,unFechaCompra){
			refuerzo = refuerzoIni
			valorBaseArmadura = valorBaseArmaduraIni
		}
	override method pesoTotal(duenio) = super(duenio) + refuerzo.peso()
	override method unidadesDeLucha(duenio) = valorBaseArmadura + refuerzo.valor(duenio)
	override method monedas() = refuerzo.monedas(valorBaseArmadura)
}

class EspejoFantastico inherits Artefacto{
	override method unidadesDeLucha(duenio){
		if(duenio.artefactos().size() <= 1){
			return 0
		}else{
			return duenio.mejorArtefacto().unidadesDeLucha(duenio)
		} 
	}
	override method monedas() = 90
}

// Es indistinto que sean unicos los espejos ya que al solo tener metodos y no atributos, no es necesaria la existencia de uno nuevo por cada personaje que posea uno