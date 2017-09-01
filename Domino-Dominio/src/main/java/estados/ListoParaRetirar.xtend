package estados

import pedido.Pedido

class ListoParaRetirar extends EstadoDePedido {
	
	 override siguiente(Pedido unPedido){
		var estadoSiguiente = this.proximo()
		unPedido.estadoActual = estadoSiguiente
		unPedido.notifyObservers
			
	}
	
	override proximo() {
		var proximoEstado = new Entregado
		proximoEstado
	}
	
	override previo() {
		var proximoPrevio = new Preparando
		proximoPrevio
	}
	

	
}