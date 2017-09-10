package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este cancelado


class Cancelado extends EstadoDePedido {
	
	// Metodos
	override cancelar(Pedido unPedido)
	{	}
	
	override proximo() {
		this
	}
	
	override previo() {
		this
	}
	
	override nombre() {
		"Cancelado"
	}
	
}
