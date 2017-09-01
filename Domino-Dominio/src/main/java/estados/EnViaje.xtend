package estados

import pedido.Pedido

class EnViaje extends EstadoDePedido {
	
	 override siguiente(Pedido unPedido){
		var estadoSiguiente = this.proximo()
		unPedido.estadoActual = estadoSiguiente
		unPedido.notify()
			
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