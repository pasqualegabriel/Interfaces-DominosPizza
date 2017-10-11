package persistencia

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pedido.Pedido
import org.apache.commons.lang.StringUtils

@Accessors
class HomePedido {

	static HomePedido instance

	static def getInstance() {
		if (instance == null) {
			instance = new HomePedido
		}
		instance
	}

	// Estructura
	List<Pedido> pedidosAbiertos = newArrayList
	List<Pedido> pedidosCerrados = newArrayList

	// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	// -El pedido no puede ya estar en la lista de pedidos abiertos
	def agregarPedido(Pedido unPedido) {

		pedidosAbiertos.add(unPedido)

	}

	def void moverPedidoAPedidosCerrado(Pedido unPedido) {
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}
	
	def searchPedidoPorEstado(String nombreDeEstado) 
	{
		if (StringUtils.isBlank(nombreDeEstado)) 
		{	this.pedidosAbiertos	}
		else 
		{	this.pedidosAbiertos.filter[it.estadoActual.nombre.toLowerCase.contains(nombreDeEstado.toLowerCase)].toList	}
	}
	
}
