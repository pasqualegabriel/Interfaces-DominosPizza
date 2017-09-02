package pasajes

import pedido.Pedido
import domino.DominoPizza

class PasajeACancelado implements Pasaje{
	
	override ejecutar(Pedido unPedido, DominoPizza unDominoPizza) {
		
		unDominoPizza.agregarPedidosCancelados(unPedido)
	}
	
}