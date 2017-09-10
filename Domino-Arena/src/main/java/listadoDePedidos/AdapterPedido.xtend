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
import plato.PlatoAdapter

@Accessors
@TransactionalAndObservable
class AdapterPedido {

	String nombre
	Pedido pedido
	EstadoDePedido estadoActual
	EstadoDePedido cambioDeEstado
	List<EstadoDePedido> estadosSelector  = newArrayList
	List<PlatoAdapter> 		platos = newArrayList
	PlatoAdapter platoSeleccionado
	
	 
	String precio

	new(Pedido unPedido, int nroPedido) {
		super()
		nombre = "Pedido " + nroPedido
		pedido = unPedido
		estadoActual= unPedido.estadoActual
		
		coleccionDeEstados
		coleccionDePlatosAdapater
		precio = "$" + pedido.calcularPrecio.toString
		
		
	}
	
	def void coleccionDePlatosAdapater() {
		
		for(Plato unPlato: pedido.platos){
			platos.add(new PlatoAdapter(unPlato))
		}
		
	}
	
	def void coleccionDeEstados() {
		estadosSelector.add(new Entregado)
		estadosSelector.add(new Preparando)
		estadosSelector.add(new Cancelado)
		estadosSelector.add(new EnViaje)
		estadosSelector.add(new ListoParaEnviar)
		estadosSelector.add(new ListoParaRetirar)
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

	//Protocolo
	def siguienteEstado() {
		pedido.siguiente
		this.estadoActual = pedido.estadoActual
	}

	def void anteriorEstado() {
		pedido.anterior
		this.estadoActual = pedido.estadoActual
	}



}
