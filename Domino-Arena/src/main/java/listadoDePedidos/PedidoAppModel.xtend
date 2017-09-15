package listadoDePedidos

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import estados.EstadoDePedido
import java.util.List
import pedido.Plato
import persistencia.Home

@Accessors
@TransactionalAndObservable
class PedidoAppModel {
	
	Boolean pedidoCerrado
	Pedido pedidoAdaptado
	Integer nroPedido
	String estadoActual
	EstadoDePedido cambioDeEstado
	List<EstadoDePedido> estadosSelector = newArrayList
	List<Plato> itemsPlatos = newArrayList
	Plato platoSeleccionado
	String costoDeEnvio

	new(Pedido unPedido, Boolean cerradoONo) {
		super()
		pedidoAdaptado = unPedido
		estadoActual = unPedido.estadoActual.nombre
		cambioDeEstado = unPedido.estadoActual
		coleccionDeEstados
		coleccionDePlatos
		costoDeEnvio = "$" + pedidoAdaptado.formaDeRetiro.precioDeRetiro
		pedidoCerrado = cerradoONo

	}

	def void coleccionDePlatos() {

		for (Plato unPlato : pedidoAdaptado.platos) {
			itemsPlatos.add(unPlato)
		}

	}

	def void agregarPlatoAdapter(Plato unPlato) {
		pedidoAdaptado.agregarPlato(unPlato)
		itemsPlatos.add(unPlato)

	}

	def void coleccionDeEstados() {
		this.estadosSelector = newArrayList
		// una opcion seria que los estados sepan responder si tienen siguente o anterior 
		// y controlarlos con dos if separados
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Preparando") &&
			!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado")) {
			estadosSelector.add(pedidoAdaptado.estadoActual.previo)
		}
		estadosSelector.add(pedidoAdaptado.estadoActual)
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado")) {
			estadosSelector.add(pedidoAdaptado.estadoActual.proximo)
		}
	}

	def void pasarASiguienteEstado() {
		this.pedidoAdaptado.siguiente()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados // Refresca la lista del Selector
	}

	def void pasarAAnteriorEstado() {
		this.pedidoAdaptado.anterior()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados // Refresca la lista del Selector
	}

	def void cambiarAEstadoSeleccionado() {
		this.pedidoAdaptado.estadoActual = this.cambioDeEstado
		this.estadoActual = this.pedidoAdaptado.estadoActual.nombre

		if (this.cambioDeEstado.nombre.equalsIgnoreCase("Entregado"))
			pedidoAdaptado.calcularTiempoDeEntrega()
		Home.instance.moverPedidoAPedidosCerrado(pedidoAdaptado)

		this.coleccionDeEstados // Refresca la lista del Selector
		this.cambioDeEstado = pedidoAdaptado.estadoActual
	}

	def void cancelar() {
		this.pedidoAdaptado.cancelar
	}

	def getHora() {
		pedidoAdaptado.fecha.toLocalTime.hour.toString + ":" + pedidoAdaptado.fecha.toLocalTime.minute.toString
	}

	def getNombreDeEstado() {
		pedidoAdaptado.estadoActual.nombre
	}

	def getPrecio() {
		"$" + pedidoAdaptado.calcularPrecio
	}

	def getFecha() {
		this.pedidoAdaptado.fecha.toLocalDate
	}

	def getTiempoDeEspera() {
		if (this.pedidoAdaptado.tiempoDeEspera == 0)
			"-"
		else
			this.pedidoAdaptado.tiempoDeEspera.toString + " Minutos"
	}

	def eliminarPlato() {
		pedidoAdaptado.quitarPlato(platoSeleccionado)
		itemsPlatos.remove(platoSeleccionado)
		platoSeleccionado = null

	}

}