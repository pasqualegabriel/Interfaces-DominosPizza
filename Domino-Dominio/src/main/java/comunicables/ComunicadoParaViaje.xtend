package comunicables

class ComunicadoParaViaje implements Comunicable {
	
	override tituloMensaje() {
		"Pedido en Viaje!"
	}
	
	override cuerpoMensaje() {
		"Su Pedido de ya esta en camino!"
	}
	
}