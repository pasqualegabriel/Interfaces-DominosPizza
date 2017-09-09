package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este listo para enviar
//                  -Indicar cual es el siguiente o anterior estado que le sigue

class ListoParaEnviar extends EstadoDePedido
{
	// Metodos
	override void siguiente(Pedido unPedido)
	{
		super.siguiente(unPedido)
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