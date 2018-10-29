import efectosGlobales.*
import spells.*
import artefactos.*
import feriaHechiceria.*

class Personaje {
	var property valorBaseLucha = 1
	const valorBaseHechiceria = 3
	var property artefactos 
	var property oro = 100
	var property hechizos
	var property hechizoPreferido
	var capacidadDeCarga
	var espejoFantastico = new EspejoFantastico(10,new Date(10,4,2015)) // creamos este objeto para evitar problemas con el metodo mejorArtefacto()
	
	constructor (artefactosIni,hechizosIni,hechizoPreferidoIni,unCapacidadDeCarga){
		artefactos = artefactosIni
		hechizos = hechizosIni
		hechizoPreferido = hechizoPreferidoIni
		capacidadDeCarga = unCapacidadDeCarga
	}
	
	method habilidadLucha() = valorBaseLucha + artefactos.sum({artefacto => artefacto.unidadesDeLucha(self)})

	method nivelDeHechiceria() = valorBaseHechiceria* hechizoPreferido.poder() + fuerzaOscura.valor()
	
	method seCreePoderoso() = hechizoPreferido.esPoderoso()
	
	method luchaMayorHechiceria() = self.habilidadLucha() > self.nivelDeHechiceria()
	
	method mejorArtefacto() = artefactos.filter({artefacto => !artefacto.equals(espejoFantastico)}).max({artefacto => artefacto.unidadesDeLucha(self)})
	
	method estaCargado() = artefactos.size() >= 5
	
	method cargaActual() = artefactos.sum{unArtefacto => unArtefacto.pesoTotal(self)}
	
	method puedeCostear(valor) = oro > valor
	
	method puedeLlevar(artefacto) = artefacto.pesoTotal(self)+self.cargaActual() <= capacidadDeCarga
	
	method agregarArtefacto(artefacto){
		artefactos.add(artefacto)
	}
	method removerArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	method cumplirObjetivo(){
		oro +=10
	}
	
	method pagar(precio){
		oro -= precio
	}
		
	method canjearHechizo(hechizo){
		if(self.puedeCostear(feriaHechiceria.precioDeVenta(self,hechizo))){
			self.pagar(feriaHechiceria.precioDeVenta(self,hechizo))
			hechizoPreferido = hechizo
		}else{
			self.error("El personaje no tiene oro suficiente para canjear el hechizo")
		}
	}
	
	method comprarArtefacto(artefacto,comerciante){
		if(!self.puedeCostear(comerciante.precio(artefacto))) 
			self.error("Error al realizar la compra")
		if(!self.puedeLlevar(artefacto))
			self.error("Error al realizar la compra")
		self.pagar(comerciante.precio(artefacto))
		self.agregarArtefacto(artefacto)
	}
}

class NPC inherits Personaje {
	var property nivel
	constructor (artefactosIni,hechizosIni,hechizoPreferidoIni,unCapacidadDeCarga,unNivel) =
		super(artefactosIni,hechizosIni,hechizoPreferidoIni,unCapacidadDeCarga){
			nivel = unNivel
		}
	override method habilidadLucha() = super()*nivel.multiplicador()
}

class Nivel{
	var property multiplicador
	constructor(unMultiplicador){
		multiplicador = unMultiplicador
	}
}