package estados

import pedido.Pedido

class Cancelado extends EstadoDePedido {
	
	override cancelar(Pedido unPedido)
	{	}
	
	override proximo() {
		this
	}
	
	override previo() {
		this
	}
}
