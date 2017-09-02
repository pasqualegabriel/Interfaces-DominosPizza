package pasajes

import pedido.Pedido
import domino.DominoPizza

interface Pasaje {
	def void ejecutar(Pedido unPedido, DominoPizza unDominoPizza)
}