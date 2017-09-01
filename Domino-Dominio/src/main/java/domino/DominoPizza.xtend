package domino

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import java.util.List
import java.util.Observer
import java.util.Observable
import pedido.Pedido

/**
 *  Responsabilidad:  Contener el menu, y controlar el manejo de los pedidos.
 */

@Accessors
class DominoPizza implements Observer {
	
	// Estructura
	
	List<Pedido> pedidosAbiertos
	List<Pedido> pedidosCerrados
	MenuDomino 	 menuDisponible
	
	// Constructores
	
	new(){
		super()
		pedidosAbiertos = new ArrayList<Pedido>
		pedidosCerrados = new ArrayList<Pedido>
		menuDisponible  = new MenuDomino
	}
	
	// Metodos
	
	// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	// 				 -El pedido no puede ya estar en la lista de pedidos abiertos
	def agregarPedido(Pedido unPedido) { 
		pedidosAbiertos.add(unPedido)
	}
	
	// Toma un pedido que se encuentra dentro de los pedidos abiertos, lo quita de ahi y lo agrega a los pedidos cerrados
	// Precondicion: El pedido tiene que estar en los pedidos abiertos.
	def cerrarPedido(Pedido unPedido) {
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}
	
	override update(Observable unPedido, Object arg) {
		//var pedido = unPedido as Pedido	
		
	}
	
}
