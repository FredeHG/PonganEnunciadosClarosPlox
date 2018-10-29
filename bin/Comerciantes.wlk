import efectosGlobales.*
import artefactos.*

class Comerciante{
	var property recategorizacion = false
	method recategorizar(){
		recategorizacion = true
	}
	method precio(artefacto) = artefacto.monedas()
	method impuestoALaGanancia(artefacto){
		if(artefacto.monedas() > minimoNoImponible.impuesto()){
			return (artefacto.monedas()-minimoNoImponible.impuesto())*0.35
		}
		return 0
	}
	method impuestoValorAgregado(artefacto) = artefacto.monedas()*iva.impuesto()
	
}

class ComercianteIndependiente inherits Comerciante{
	var property comision
	constructor (unComision) {
		comision = unComision
	}
	override method recategorizar(){
		super()
		comision *= 2
	}
	method comisionar(artefacto) = return comision*artefacto.monedas() + artefacto.monedas() 
	override method precio(artefacto) {
		if(!recategorizacion){
			return self.comisionar(artefacto)
		}
		if(comision > 0.21){
			return artefacto.monedas() + self.impuestoValorAgregado(artefacto)
		}
		return self.comisionar(artefacto)
	}
}

class ComercianteRegistrado inherits Comerciante{
	override method precio(artefacto) { 
		if(!recategorizacion){
			return super(artefacto) + self.impuestoValorAgregado(artefacto)
		}
		return super(artefacto) + self.impuestoALaGanancia(artefacto)
	}
}

class ComercianteConImpuestoGanancias inherits Comerciante{
	override method precio(artefacto) = super(artefacto) + self.impuestoALaGanancia(artefacto)
}