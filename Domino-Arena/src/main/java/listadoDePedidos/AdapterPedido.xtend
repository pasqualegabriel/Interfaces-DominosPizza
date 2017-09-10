package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import persistencia.Home
import estados.EstadoDePedido
import estados.EnViaje
import estados.Entregado
import java.util.List
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pedido.Plato
import pizza.Chica
import pizza.Pizza
import pizza.Distribucion

@Accessors
@TransactionalAndObservable
class AdapterPedido {

	String nombre
	Pedido pedido
	EstadoDePedido estadoActual
	String precio
	List<EstadoDePedido> estados
	List<Plato> 		platos
	Plato platoSeleccionado
	

	new(Pedido unPedido, int nroPedido) {
		super()
		nombre = "Pedido " + nroPedido
		pedido = unPedido
		estadoActual= unPedido.estadoActual
		precio = "$" + pedido.calcularPrecio.toString
		
		estados = newArrayList
		estados.add(new EnViaje)
		estados.add(new Entregado)
		
		platos = newArrayList
		var plato1 = new Plato(new Pizza("Pizza1",10,new Distribucion), new Chica, new Distribucion)
		plato1.nombre = "Plato1"
		platos.add(plato1)
	}

	def getHora() {
		pedido.fecha.toLocalTime.toString
	}
	
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
