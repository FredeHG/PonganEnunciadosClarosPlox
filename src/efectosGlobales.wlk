object fuerzaOscura {
	var property valor = 5
	
	method eclipse(){
		valor *= 2
	}
}

object fechaActual{
	var property fecha = new Date(28,10,2018)
	method actualizarFecha(dia,mes,anio){
		fecha = new Date(dia,mes,anio)
	}
}

object iva{
	method impuesto() = 0.21
}

object minimoNoImponible{
	var property impuesto = 100
}