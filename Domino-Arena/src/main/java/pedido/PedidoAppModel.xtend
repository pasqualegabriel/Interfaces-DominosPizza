package pedido

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import estados.EstadoDePedido
import java.util.List
import pedido.Plato
import persistencia.HomePedido
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class PedidoAppModel 
{
	Pedido pedidoAdaptado
	Integer nroPedido
	String estadoActual
	EstadoDePedido cambioDeEstado
	List<EstadoDePedido> estadosSelector= newArrayList
	List<Plato> itemsPlatos 			= newArrayList
	Plato platoSeleccionado
	Double costoDeEnvio
	Double precio
	List<Plato> pedidosAAgregar 		= newArrayList

	new(Pedido unPedido) 
	{
		super()
		pedidoAdaptado = unPedido
		estadoActual = unPedido.estadoActual.nombre
		cambioDeEstado = unPedido.estadoActual
		coleccionDeEstados
		coleccionDePlatos
		costoDeEnvio = pedidoAdaptado.formaDeRetiro.precioDeRetiro
		calcularPrecio
	}

	/**Devuelve True si el pedido no esta cerrado (No es cancelado y no es entregado)*/
	def noEstaCerrado() 
	{
		!(pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Cancelado") ||
			pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado"))
	}

	/**Devuelve true si hay un plato seleccionado*/
	@Dependencies("platoSeleccionado")
	def getSePuedeEditar() 
	{	platoSeleccionado != null	}

	/**Devuelve una coleccion con todos los platos del pedido */
	def void coleccionDePlatos() 
	{
		for (Plato unPlato : pedidoAdaptado.platos) 
		{	itemsPlatos.add(unPlato)	}
	}

	/**Devuelve una lista de los estados a los que puede pasar el pedido actual */
	def void coleccionDeEstados() 
	{
		this.estadosSelector = newArrayList
		/*Si el estado del pedido no es preparado o entregado  agrega el estado previo al actual*/
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Preparando") &&
			!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado")) 
		{	estadosSelector.add(pedidoAdaptado.estadoActual.previo)	}
		estadosSelector.add(pedidoAdaptado.estadoActual)
		/*Si el estado del pedido no es entregado agrega el estado proximo al actual*/
		if (!pedidoAdaptado.estadoActual.nombre.equalsIgnoreCase("Entregado")) 
		{	estadosSelector.add(pedidoAdaptado.estadoActual.proximo)	}
	}

	/**Hace que el pedido pase al estado que le sigue del estado actual*/
	def void pasarASiguienteEstado() 
	{
		this.pedidoAdaptado.siguiente()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados // Refresca la lista del Selector
	}

	def void pasarAAnteriorEstado() {
		this.pedidoAdaptado.anterior()
		this.estadoActual = pedidoAdaptado.estadoActual.nombre
		this.coleccionDeEstados // Refresca la lista del Selector
	}

	/**Cambia el estado del pedido al estado que esta seleccionado */
	def void cambiarAEstadoSeleccionado() 
	{
		this.pedidoAdaptado.estadoActual = this.cambioDeEstado
		this.estadoActual = this.pedidoAdaptado.estadoActual.nombre

		/*Se fija si el estado a cambiar es al estado entregado, 
		 * si es asi lo mueve a la lista de pedidos cerrados y calcula el tiempo de entrega*/
		if (this.cambioDeEstado.nombre.equalsIgnoreCase("Entregado")) 
		{
			pedidoAdaptado.calcularTiempoDeEntrega()
			HomePedido.instance.moverPedidoAPedidosCerrado(pedidoAdaptado)
		}

		this.coleccionDeEstados // Refresca la lista del Selector
		this.cambioDeEstado = pedidoAdaptado.estadoActual
	}

	/**Da la orden de cancelar al pedido */
	def void cancelar() 
	{	this.pedidoAdaptado.cancelar	}

	/**Devuelve la hora del pedido en un formato que se pueda ver en la vista */
	def getHora() 
	{	'''«pedidoAdaptado.fecha.toLocalTime.hour»:«pedidoAdaptado.fecha.toLocalTime.minute»'''}

	/**Devuelve el nombre del estado actual del pedido */
	def getNombreDeEstado() 
	{	pedidoAdaptado.estadoActual.nombre	}

	/**Devuelve el precio del pedido */
	def getPrecio() 
	{ precio }

	/**Realiza el calculo de precio del pedido*/
	def void calcularPrecio() 
	{	precio = itemsPlatos.stream.mapToDouble[it.calcularPrecio].sum + costoDeEnvio	}

	/**Da la fecha del pedido en formato DD-MM-AAAA */
	def getFecha() 
	{	this.pedidoAdaptado.fecha.toLocalDate	}

	/**Devuelve el tiempo de espera que tuvo un pedido desde que se creo hasta que se entrego.*/
	def getTiempoDeEspera() 
	{	
		if (this.pedidoAdaptado.tiempoDeEspera == 0)
			"-"
		else
			'''«this.pedidoAdaptado.tiempoDeEspera» Minutos"'''
	}

	/**Agrega un nuevo plato a la lista de platos */
	def void agregarPlatoAdapter(Plato unPlato) 
	{
		itemsPlatos.add(unPlato)
		calcularPrecio
	}

	/**Elimina el plato seleccionado de la lista de platos */
	def eliminarPlato() 
	{
		itemsPlatos.remove(platoSeleccionado)
		platoSeleccionado = null
		calcularPrecio
	}

	/**Al aceptar los cambios desde la ventana, guarda la lista de paltos en el pedido */
	def aceptarCambios() 
	{	pedidoAdaptado.platos = itemsPlatos	}

	/**Da el costo de envio en un formato adaptador para la vista */
	@Dependencies("costoDeEnvio")
	def getCostoDeEnvio() 
	{	'''$ «costoDeEnvio»'''	}

	/**Da elprecio en un formato adaptador para la vista */
	@Dependencies("precio")
	def getPrecioMostrable() 
	{	'''$ «precio»'''	}

}
