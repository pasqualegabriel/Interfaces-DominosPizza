package comunicables

// Responsabilidad: Contener la informacion y estructura del mensaje que el usuario recibe
//           		cuando su pedido esta en camino

class ComunicadoParaViaje implements Comunicable {
	
	// Metodos
	override tituloMensaje() {
		"Pedido en Viaje!"
	}
	
	override cuerpoMensaje() {
		"Su Pedido ya esta en camino!"
	}
	
}