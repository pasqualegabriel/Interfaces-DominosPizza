package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import persistencia.Home
import estados.EstadoDePedido

@Accessors
@Observable
class AdapterPedido {

	String nombre
	Pedido pedido
	EstadoDePedido estadoActual
	String precio

	new(Pedido unPedido, int nroPedido) {
		super()
		nombre = "Pedido " + nroPedido
		pedido = unPedido
		estadoActual= unPedido.estadoActual
		precio = "$" + pedido.calcularPrecio.toString
	}

	def getHora() {
		pedido.fecha.toLocalTime.toString
	}

//	def getCalcularPrecio() {
//		precio = pedido.calcularPrecio.toString
//	
//	}
	 

	
	def getEstadoActual() {
		estadoActual.nombre
	}

	def getCancelar() {
		pedido.cancelar
		Home.instance.cerrarPedidoEntregado(pedido)
	}

	def siguienteEstado() {
		pedido.siguiente
		this.estadoActual = pedido.estadoActual
	}

	def void anteriorEstado() {
		pedido.anterior
		this.estadoActual = pedido.estadoActual
	}

}
