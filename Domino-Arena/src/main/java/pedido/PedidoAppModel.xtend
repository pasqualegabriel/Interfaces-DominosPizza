package pedido

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import estados.EstadoDePedido
import java.util.List
import pedido.Plato
import persistencia.HomePedido
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class PedidoAppModel {
	
	Pedido pedidoAdaptado
	Integer nroPedido
	EstadoDePedido cambioDeEstado
	List<EstadoDePedido> estadosSelector	= newArrayList
	List<Plato> itemsPlatos 				= newArrayList
	int cantPlatos = 0
	Plato platoSeleccionado
	Double costoDeEnvio
	Double precio

	new(Pedido unPedido) {
		super()
		pedidoAdaptado = unPedido
		cambioDeEstado = unPedido.estadoActual
		coleccionDeEstados
		coleccionDePlatos
		costoDeEnvio = pedidoAdaptado.formaDeRetiro.precioDeRetiro
		calcularPrecio
	}

	/**Devuelve True si el pedido no esta cerrado (No es cancelado y no es entregado)*/
	def noEstaCerrado() {
		!(pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Cancelado") ||
			pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado"))
	}

	/**Devuelve true si hay un plato seleccionado*/
	@Dependencies("platoSeleccionado")
	def getSePuedeEditar() { 
		platoSeleccionado != null
	}

	@Dependencies("platoSeleccionado","cantPlatos")
	def getSePuedeEliminar() {
		platoSeleccionado != null && cantPlatos > 1

	}

	/**Devuelve una coleccion con todos los platos del pedido */
	def void coleccionDePlatos() {
		pedidoAdaptado.platos.forEach[itemsPlatos.add(it)]
		cantPlatos = itemsPlatos.length
	}

	/**Devuelve la hora del pedido en un formato que se pueda ver en la vista */
	def getHora() {
		'''«pedidoAdaptado.fecha.toLocalTime.hour»:«pedidoAdaptado.fecha.toLocalTime.minute»'''
	}

	/**Realiza el calculo de precio del pedido*/
	def void calcularPrecio() {
		precio = itemsPlatos.stream.mapToDouble[it.calcularPrecio].sum + costoDeEnvio
	}

	/**Da la fecha del pedido en formato DD-MM-AAAA */
	def getFecha() { this.pedidoAdaptado.fecha.toLocalDate }

	/**Devuelve el tiempo de espera que tuvo un pedido desde que se creo hasta que se entrego.*/
	def getTiempoDeEspera() {
		if (this.pedidoAdaptado.tiempoDeEspera == 0)
			"-"
		else '''«this.pedidoAdaptado.tiempoDeEspera» Minutos"'''
	}

	/**Da el costo de envio en un formato adaptador para la vista */
	@Dependencies("costoDeEnvio")
	def getCostoDeEnvio() {
		'''$ «costoDeEnvio»'''

	}

	/**Da elprecio en un formato adaptador para la vista */
	@Dependencies("precio","itemsPlatos")
	def getPrecioMostrable() {
		'''$ «precio»'''

	}

	/**Devuelve una lista de los estados a los que puede pasar el pedido actual 
	 * Precondicion: El estado actual nunca puede ser Entregado
	 */
	def void coleccionDeEstados() {
		this.estadosSelector = newArrayList
		/*Si el estado del pedido no es preparado o entregado  agrega el estado previo al actual*/
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Preparando")) {
			estadosSelector.add(pedidoAdaptado.estadoActual.previo)
		}
		estadosSelector.add(pedidoAdaptado.estadoActual)
		/*Si el estado del pedido no es entregado agrega el estado proximo al actual*/
//		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado")) {
			estadosSelector.add(pedidoAdaptado.estadoActual.proximo)
//		}
	}

	/**Protocolo/

	 /**Cambia el estado del pedido al estado que esta seleccionado */
	def void cambiarAEstadoSeleccionado() {
		this.pedidoAdaptado.estadoActual = this.cambioDeEstado
		/**Se fija si el estado a cambiar es al estado entregado, 
		 * si es asi lo mueve a la lista de pedidos cerrados y calcula el tiempo de entrega*/
		if (this.cambioDeEstado.nombre.equalsIgnoreCase("Entregado")) {
			pedidoAdaptado.calcularTiempoDeEntrega
			pedidoAdaptado.agregarAlHistorial
			HomePedido.instance.moverPedidoAPedidosCerrado(pedidoAdaptado)
		}
	}

	/**Da la orden de cancelar al pedido */
	def void cancelar() {
		pedidoAdaptado.cancelar
	}

	/**Agrega un nuevo plato a la lista de platos */
	def void agregarPlato(Plato unPlato) {
		itemsPlatos.add(unPlato)
		cantPlatos++
		calcularPrecio
	}

	/**Elimina el plato seleccionado de la lista de platos */
	def eliminarPlato() {
		itemsPlatos.remove(platoSeleccionado)
		cantPlatos--
		platoSeleccionado = null
		calcularPrecio
	}

	/**Al aceptar los cambios desde la ventana, guarda la lista de paltos en el pedido */
	def aceptarCambios() {
		pedidoAdaptado.platos = itemsPlatos
	}

}
