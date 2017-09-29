package pedido

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import estados.EstadoDePedido
import java.util.List
import pedido.Plato
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
	Plato platoSeleccionado
	Double costoDeEnvio

	new(Pedido unPedido) {
		super()
		pedidoAdaptado = unPedido
		cambioDeEstado = unPedido.estadoActual
		coleccionDeEstados
		agregarPlatosAItems
		costoDeEnvio = pedidoAdaptado.formaDeRetiro.precioDeRetiro
	}

	/**Devuelve True si el pedido no esta cerrado (No es cancelado y no es entregado)*/
	def noEstaCerrado() {
		!pedidoAdaptado.estaCerrado
	}

	/**Devuelve true si hay un plato seleccionado*/
	@Dependencies("platoSeleccionado")
	def getSePuedeEditar() { 
		platoSeleccionado != null
	}

	/**Devuelve true si el plato es eliminable*/
	@Dependencies("platoSeleccionado","itemsPlatos")
	def getSePuedeEliminar() {
		platoSeleccionado != null && itemsPlatos.size > 1

	}


	def getItemsPlatos()
	{
		itemsPlatos
	}

	/**Devuelve una coleccion con todos los platos del pedido */
	def void agregarPlatosAItems() { //Corregido
		pedidoAdaptado.platos.forEach[itemsPlatos.add(it)]
	}

	/**Devuelve la hora del pedido en un formato que se pueda ver en la vista */
	def getHora() { //Corregido
		pedidoAdaptado.fecha.toLocalTime
	}

	/**Realiza el calculo de precio del pedido*/
	@Dependencies("itemsPlatos")
	def getPrecio() {
		itemsPlatos.stream.mapToDouble[it.getPrecio].sum + costoDeEnvio
	}

	/**Da la fecha del pedido en formato DD-MM-AAAA */
	def getFecha() { this.pedidoAdaptado.fecha.toLocalDate }


	/**Da el costo de envio en un formato adaptador para la vista */
	def getCostoDeEnvio() { 
		costoDeEnvio
	}

	/**Devuelve una lista de los estados a los que puede pasar el pedido actual 
	 * Precondicion: El estado actual nunca puede ser Entregado
	 */
	def void coleccionDeEstados() {
		this.estadosSelector = newArrayList
		/*Si el estado del pedido no es preparado o entregado  agrega el estado previo al actual*/
		if (!pedidoAdaptado.estaPreparando) { //CORREGIDO
			estadosSelector.add(pedidoAdaptado.estadoActual.previo)
		}
		estadosSelector.add(pedidoAdaptado.estadoActual)
		if (pedidoAdaptado.estaPreparando) { //CORREGIDO
			estadosSelector.add(pedidoAdaptado.formaDeRetiro.avanzarEstado)
		}
		else
		{
			estadosSelector.add(pedidoAdaptado.estadoActual.proximo)
		}
		
	}

	/**Protocolo/

	 /**Cambia el estado del pedido al estado que esta seleccionado */
	def void cambiarAEstadoSeleccionado() { //CORREGIDO
		pedidoAdaptado.cambiarAEstado(this.cambioDeEstado)
	}

	/**Da la orden de cancelar al pedido */
	def void cancelar() {
		pedidoAdaptado.cancelar
	}

	/**Agrega un nuevo plato a la lista de platos */
	def void agregarPlato(Plato unPlato) {
		itemsPlatos.add(unPlato)
	}

	/**Elimina el plato seleccionado de la lista de platos */
	def eliminarPlato() {
		itemsPlatos.remove(platoSeleccionado)
		platoSeleccionado = null
	}

	/**Al aceptar los cambios desde la ventana, guarda la lista de paltos en el pedido */
	def aceptarCambios() {
		pedidoAdaptado.platos = itemsPlatos
	}
	
	def getNuevoPlato()
	{
		var Plato nuevoPlato=new Plato()
		itemsPlatos.add(nuevoPlato)
		nuevoPlato
	}
	
	def void setPlatoSeleccionado(Plato unPlato)
	{
		platoSeleccionado = unPlato
	}
}
