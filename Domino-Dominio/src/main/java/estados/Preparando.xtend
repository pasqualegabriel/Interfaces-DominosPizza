package estados

import pedido.Pedido

class Preparando extends EstadoDePedido{
	
	new(){
		super()
		nombre = "Preparando"
	}

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
}