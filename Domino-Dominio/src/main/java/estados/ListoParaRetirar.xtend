package estados

import pedido.Pedido
import pasajes.PasajeAEntregado

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este listo para retirar
//                  -Indicar cual es el siguiente o anterior estado que le sigue

class ListoParaRetirar extends EstadoDePedido {
	
	// Metodos
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