package estados

import pedido.Pedido

class Entregado extends EstadoDePedido {
	
	override cancelar(Pedido unPedido)
	{	}
	
	override proximo() {
		this
	}
	
	override previo() {
		this
	}
	
}
