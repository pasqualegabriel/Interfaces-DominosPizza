

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import java.util.List

/**
 *  Responsabilidad:  Contener el menu, y controlar el manejo de los pedidos.
 */

@Accessors
class DominoPizza {
	
	//Estructura
	List<Pedido> pedidosAbiertos
	List<Pedido> pedidosCerrados
	MenuDomino menuDisponible
	
	//Constructores
	
	new(){
		super()
		pedidosAbiertos = new ArrayList<Pedido>
		pedidosCerrados = new ArrayList<Pedido>
		menuDisponible = new MenuDomino
	}
	
	//Metodos
	
	
	def agregarPedido(Pedido unPedido) {
		pedidosAbiertos.add(unPedido)
	}
	
	//toma un pedido que se encuentra dentro de los pedidos abiertos, lo quita de ahi y lo agrega a los pedidos cerrados
	def cerrarPedido(Pedido unPedido) {
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}
	
}