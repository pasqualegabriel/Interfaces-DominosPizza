package pasajes

import pedido.Pedido
import persistencia.Home

// Responsabilidad: Encapsular el comportamiento de  los cambios que dominoPizza tiene que hacer 
//					sobre y con el pedido cuando su estado pasa a estar cancelado

class PasajeACancelado implements Pasaje{
	
	override ejecutar(Pedido unPedido, Home unDominoPizza) {
		
		unDominoPizza.agregarPedidosCancelados(unPedido)
	}
	
}