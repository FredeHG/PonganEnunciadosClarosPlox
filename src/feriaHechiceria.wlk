object feriaHechiceria {
	method precioDeVenta(personaje,hechizo) = 0.max(hechizo.monedas() - personaje.hechizoPreferido().monedas() / 2)
}