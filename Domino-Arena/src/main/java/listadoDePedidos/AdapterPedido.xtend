package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import persistencia.Home
import estados.EstadoDePedido
import java.util.List
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pedido.Plato
import estados.Cancelado
import estados.Preparando
import estados.Entregado
import estados.EnViaje
import estados.ListoParaEnviar
import estados.ListoParaRetirar

@Accessors
@TransactionalAndObservable
class AdapterPedido {

	String nombre
	Pedido pedido
	EstadoDePedido estadoActual
	String precio
	List<EstadoDePedido> estadosSelector 
	List<Plato> 		platos = newArrayList
	Plato platoSeleccionado
	EstadoDePedido cambioDeEstado 
	

	new(Pedido unPedido, int nroPedido) {
		super()
		nombre = "Pedido " + nroPedido
		pedido = unPedido
		estadoActual= unPedido.estadoActual
		precio = "$" + pedido.calcularPrecio.toString
		estadosSelector = this.coleccionDeEstados
		platos	= pedido.platos
	}
	
	def coleccionDeEstados() {
		var coleccion = newArrayList
		coleccion.add(new Entregado)
		coleccion.add(new Preparando)
		coleccion.add(new Cancelado)
		coleccion.add(new EnViaje)
		coleccion.add(new ListoParaEnviar)
		coleccion.add(new ListoParaRetirar)
//		if(pedido.estadoActual.nombre.equals("Preparado")){
//			var aaa= pedido.formaDeRetiro.avanzarEstado
//			coleccion.add(aaa)
//			System.out.println(pedido.formaDeRetiro)
//			System.out.println(aaa)
//		}else{ coleccion.add(pedido.estadoActual.proximo)}

		
		coleccion
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
		estadosSelector = coleccionDeEstados
		this.estadoActual = pedido.estadoActual
	}

	def void anteriorEstado() {
		pedido.anterior
		estadosSelector = coleccionDeEstados
		this.estadoActual = pedido.estadoActual
	}



}
