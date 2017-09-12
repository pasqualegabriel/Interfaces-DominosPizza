package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este preparandose
//                  -Indicar cual es el siguiente o anterior estado que le sigue


class Preparando extends EstadoDePedido{

	// Metodos
	override siguiente(Pedido unPedido){
		var unaFormaDeEnvio = unPedido.formaDeRetiro
		var estadoSiguiente = unaFormaDeEnvio.avanzarEstado
		unPedido.estadoActual = estadoSiguiente
	
	}
	
	override previo() {
		this
	}
	
	override proximo() {
		
	}
	
	override nombre() {
		"Preparando"
	}
	
}