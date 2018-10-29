class Hechizo{
	method poder()
	method esPoderoso() = self.poder() > 15
	method monedas() = self.poder()
}

class Logo inherits Hechizo{
	var property nombre
	var indiceMultiplicador
	
	constructor(nombreIni,indiceMultiplicadorIni){
		nombre = nombreIni
		indiceMultiplicador = indiceMultiplicadorIni
	}
	
	override method poder() = nombre.size()*indiceMultiplicador
}

class HechizoBasico inherits Hechizo{
	var property nombre = "hechizoBasico"
	override method poder() = 10
}

class HechizoComercial inherits Hechizo{
	const nombre = "el hechizo comercial"
	var property porcentaje = 0.2
	var property multiplicador = 2
	override method poder() = nombre.size()*porcentaje*multiplicador
}

class LibroDeHechizos inherits Hechizo{
	const hechizos //lista hechizos
	constructor (hechizosIni){
		hechizos = hechizosIni
	}
	override method poder() = hechizos.filter{hechizo => hechizo.esPoderoso()}.sum({hechizo => hechizo.poder()})
}

