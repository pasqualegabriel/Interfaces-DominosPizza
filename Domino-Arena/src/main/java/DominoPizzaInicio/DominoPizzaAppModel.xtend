package DominoPizzaInicio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import persistencia.Home
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.util.Comparator
import java.util.ArrayList
import pedido.Pedido

@TransactionalAndObservable
@Accessors
class DominoPizzaAppModel 
{
	List<Pedido> itemsPedidosAbiertos	= newArrayList
	Pedido 		 pedidoSelectItem
	List<Pedido> itemsPedidosCerrados	= newArrayList
	
	new()
	{
		this.repoDePedidosAbiertos
		this.repoDePedidosCerrados
	}

	/**Sirve para traer todos los pedidos pasarlo a un adapterPedido y luego guardarlo en una lista */
	def getRepoDePedidosAbiertos() {
		this.itemsPedidosAbiertos.clear
		val listaActualizada		= newArrayList
		listaActualizada.addAll(Home.instance.pedidosAbiertos)
		this.itemsPedidosAbiertos = ordenarListaDePedidosAbiertosPorHoraAscendente(listaActualizada)
	
	}
	/** ordena  una  lista del pedido en orden */
	def ordenarListaDePedidosAbiertosPorHoraAscendente(ArrayList<Pedido> listaActualizada) {
		if (!listaActualizada.isEmpty || (listaActualizada.size > 1)){
			
			listaActualizada.sort(new ComparatorHoraPedidosAscendente)
		}
		listaActualizada
	}
	
	/**cierra un pedido seleccionado */
	@Dependencies("listaDePedidosAbiertos")
	def void cerrarPedidoSeleccionado()
	{
		Home.instance.moverPedidoAPedidosCerrado(this.pedidoSelectItem)
		itemsPedidosAbiertos.remove(pedidoSelectItem)
		pedidoSelectItem = null
	}
	
	/** Cancela un pedido seleccinado */
	def void cancelarPedidoSeleccionado()
	{
		pedidoSelectItem.cancelar()
		this.cerrarPedidoSeleccionado
	}
	
	/**Pasa al siguiente estado */
	@Dependencies("itemsPedidosAbiertos")
	def void siguienteEstadoPedidoSeleccionado()
	{
		pedidoSelectItem.siguiente
		if (pedidoSelectItem.estadoActual.nombre.equalsIgnoreCase("Entregado"))
			this.cerrarPedidoSeleccionado
		else
			this.repoDePedidosAbiertos
	}
	
	/**Pasa al anterior estado */
	@Dependencies("itemsPedidosAbiertos")
	def void anteriorEstadoPedidoSeleccionado()
	{
		pedidoSelectItem.anterior
		this.repoDePedidosAbiertos
	}
	
	/**Trae la lista de pedidos cerrados*/
	def getRepoDePedidosCerrados()
	{
		this.itemsPedidosCerrados.clear
		val listaActualizada		= newArrayList
		listaActualizada.addAll(Home.instance.pedidosCerrados)
		this.itemsPedidosCerrados = ordenarListaDePedidosCerradosPorFechaDescendente(listaActualizada)
	}
	
	/**ordena la lista de pedidos cerrados */
	def ordenarListaDePedidosCerradosPorFechaDescendente(ArrayList<Pedido> listaActualizada)
	{
		if (!listaActualizada.isEmpty || (listaActualizada.size > 1))
		{	listaActualizada.sort(new ComparatorFechaPedidosDescendente)}
		listaActualizada
	}
	
}

class ComparatorHoraPedidosAscendente implements Comparator<Pedido>
{
	override compare(Pedido o1, Pedido o2) 
	{
		if (o1.fecha.toLocalTime < o2.fecha.toLocalTime)
		{	return -1	}
		else if (o1.fecha.toLocalTime > o2.fecha.toLocalTime)
		{	return 1	}
		else
		{	return 0	}
	}
}

class ComparatorFechaPedidosDescendente implements Comparator<Pedido>
{
	override compare(Pedido o1, Pedido o2) 
	{
		if (o1.fecha.isAfter(o2.fecha))
		{	return -1	}
		else if (o1.fecha.isBefore(o2.fecha))
		{	return 1	}
		else
		{	return 0	}
	}
}
