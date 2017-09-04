package estados

import pedido.Pedido
import pasajes.PasajeAEntregado

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este en viaje
//                  -Indicar cual es el siguiente o anterior estado que le sigue

class EnViaje extends EstadoDePedido {
	
	// Metodos
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