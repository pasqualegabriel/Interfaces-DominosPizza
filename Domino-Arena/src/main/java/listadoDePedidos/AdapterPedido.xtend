package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import persistencia.Home

@Accessors
@Observable
class AdapterPedido {
	
	String nombre
	Pedido pedido
	
	new(Pedido unPedido, int nroPedido){
		super()
		nombre = "Pedido " + nroPedido
		pedido = unPedido
	}
	
	def getHora(){
		pedido.fecha.toLocalTime.toString
	}
	
	def getCalcularPrecio(){
		if(pedido.calcularPrecio.equals(null)){""}else{pedido.calcularPrecio.toString}
	}
	
	def getEstadoActual(){
		pedido.estadoActual.nombre
	}
	
	def getCancelar()
	{
		pedido.cancelar
		Home.instance.cerrarPedidoEntregado(pedido)
	}
}