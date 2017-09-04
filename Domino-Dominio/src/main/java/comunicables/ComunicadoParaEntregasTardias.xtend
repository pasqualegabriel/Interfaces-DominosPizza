package comunicables

// Responsabilidad: Contener la informacion y estructura del mensaje que el usuario recibe
//           		cuando su pedido tardo mas de 30 minutos en llegar

class ComunicadoParaEntregasTardias  implements Comunicable{
	
	// Metodos
	override tituloMensaje() {
		"Disculpas"
	}
	
	override cuerpoMensaje() {
		"Sr.Usuario le pedimos diculpas por la demora de la entrega"
	}
	
}