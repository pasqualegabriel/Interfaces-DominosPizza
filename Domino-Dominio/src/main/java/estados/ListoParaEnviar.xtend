package estados

import pedido.Pedido
import domino.PasajeEnViaje

class ListoParaEnviar extends EstadoDePedido
{
	
	override void siguiente(Pedido unPedido)
	{
		super.siguiente(unPedido)
		unPedido.notifyObservers(new PasajeEnViaje)
	}
	
	override previo() {
		var estadoPrevio = new Preparando
		estadoPrevio
	}
	
	override proximo() {
		var estadoProximo = new EnViaje
		estadoProximo
	}
	
}