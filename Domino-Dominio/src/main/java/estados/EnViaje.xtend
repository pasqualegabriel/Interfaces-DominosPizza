package estados

import pedido.Pedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este en viaje
//                  -Indicar cual es el siguiente o anterior estado que le sigue

class EnViaje extends EstadoDePedido {
	

	new(){
		super()
	}
	
	
	// Metodos
	 override siguiente(Pedido unPedido)
	 {
		var estadoSiguiente = this.proximo()
		unPedido.estadoActual = estadoSiguiente
		unPedido.calcularTiempoDeEntrega()
		
	}
	
	override proximo() {
		new Entregado
	}
	
	override previo() {
		new ListoParaEnviar
	}
	

	
}