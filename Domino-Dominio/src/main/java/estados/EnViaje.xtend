package estados

import pedido.Pedido
import domino.PasajeAEntregado

class EnViaje extends EstadoDePedido {
	
	 override siguiente(Pedido unPedido)
	 {
		super.siguiente(unPedido)
		unPedido.notifyObservers(new PasajeAEntregado)			
	}
	
	override proximo() {
		var estadoProximo = new Entregado
		estadoProximo
	}
	
	override previo() {
		var estadoPrevio = new ListoParaEnviar
		estadoPrevio
	}
	

	
}