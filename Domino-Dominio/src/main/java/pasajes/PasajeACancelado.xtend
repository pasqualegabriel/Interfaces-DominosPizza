package pasajes

import pedido.Pedido
import domino.DominoPizza

// Responsabilidad: Encapsular el comportamiento de  los cambios que dominoPizza tiene que hacer 
//					sobre y con el pedido cuando su estado pasa a estar cancelado

class PasajeACancelado implements Pasaje{
	
	override ejecutar(Pedido unPedido, DominoPizza unDominoPizza) {
		
		unDominoPizza.agregarPedidosCancelados(unPedido)
	}
	
}