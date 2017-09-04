package pasajes

import pedido.Pedido
import domino.DominoPizza

// Responsabilidad: Encapsular el comportamiento de  los cambios que dominoPizza tiene que hacer 
//					sobre y con el pedido dependiendo los nuevos estados de este

interface Pasaje {
	def void ejecutar(Pedido unPedido, DominoPizza unDominoPizza)
}