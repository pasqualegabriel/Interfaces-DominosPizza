package estados

import pedido.Pedido
import domino.PasajeAEntregado

class ListoParaRetirar extends EstadoDePedido {
	
	 override siguiente(Pedido unPedido)
	 {
		super.siguiente(unPedido)
		unPedido.notifyObservers(new PasajeAEntregado)			
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