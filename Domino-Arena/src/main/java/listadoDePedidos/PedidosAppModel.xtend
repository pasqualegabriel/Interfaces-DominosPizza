package listadoDePedidos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import persistencia.Home
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.util.Comparator
import java.util.ArrayList

@TransactionalAndObservable
@Accessors
class PedidosAppModel 
{
	List<AdapterPedido> listaDePedidosAbiertos	= newArrayList
	AdapterPedido pedidoSeleccionado
	List<AdapterPedido> listaDePedidosCerrados	= newArrayList
	
	new()
	{
		this.repoDePedidosAbiertos
		this.repoDePedidosCerrados
	}
	
	
	@Dependencies("listaDePedidosAbiertos")
	def void cerrarPedidoSeleccionado()
	{
		Home.instance.moverPedidoAPedidosCerrado(this.pedidoSeleccionado.nroPedido, this.pedidoSeleccionado.pedidoAdaptado)
		listaDePedidosAbiertos.remove(pedidoSeleccionado)
		pedidoSeleccionado = null
	}
	
	def void cancelarPedidoSeleccionado()
	{
		pedidoSeleccionado.cancelar()
		this.cerrarPedidoSeleccionado
	}
	
	@Dependencies("listaDePedidosAbiertos")
	def void siguienteEstadoPedidoSeleccionado()
	{
		pedidoSeleccionado.pasarASiguienteEstado()
		if (pedidoSeleccionado.nombreDeEstado.equalsIgnoreCase("Entregado"))
			this.cerrarPedidoSeleccionado
		else
			this.repoDePedidosAbiertos
	}
	
	@Dependencies("listaDePedidosAbiertos")
	def void anteriorEstadoPedidoSeleccionado()
	{
		pedidoSeleccionado.pasarAAnteriorEstado()
		this.repoDePedidosAbiertos
	}
	
	def getRepoDePedidosAbiertos()
	{
		this.listaDePedidosAbiertos.clear
		val listaActualizada		= newArrayList
		Home.instance.pedidosAbiertos.forEach[ claveNroPedido, valorPedido | listaActualizada.add(new AdapterPedido(claveNroPedido,valorPedido, true))]
		this.listaDePedidosAbiertos = ordenarListaDePedidosAbiertosPorHoraAscendente(listaActualizada)
	}

	def ordenarListaDePedidosAbiertosPorHoraAscendente(ArrayList<AdapterPedido> listaActualizada)
	{
		if (!listaActualizada.isEmpty || (listaActualizada.size > 1))
		{	listaActualizada.sort(new ComparatorHoraPedidosAscendente)}
		listaActualizada
	}
	
	def getRepoDePedidosCerrados()
	{
		this.listaDePedidosCerrados.clear
		val listaActualizada		= newArrayList
		Home.instance.pedidosCerrados.forEach[ claveNroPedido, valorPedido | listaActualizada.add(new AdapterPedido(claveNroPedido,valorPedido,false))]
		this.listaDePedidosCerrados = ordenarListaDePedidosCerradosPorFechaDescendente(listaActualizada)
	}
	
	def ordenarListaDePedidosCerradosPorFechaDescendente(ArrayList<AdapterPedido> listaActualizada)
	{
		if (!listaActualizada.isEmpty || (listaActualizada.size > 1))
		{	listaActualizada.sort(new ComparatorFechaPedidosDescendente)}
		listaActualizada
	}
	
}

class ComparatorHoraPedidosAscendente implements Comparator<AdapterPedido>
{
	override compare(AdapterPedido o1, AdapterPedido o2) 
	{
		if (o1.hora < o2.hora)
		{	return -1	}
		else if (o1.hora > o2.hora)
		{	return 1	}
		else
		{	return 0	}
	}
}

class ComparatorFechaPedidosDescendente implements Comparator<AdapterPedido>
{
	override compare(AdapterPedido o1, AdapterPedido o2) 
	{
		if (o1.pedidoAdaptado.fecha.isAfter(o2.pedidoAdaptado.fecha))
		{	return -1	}
		else if (o1.pedidoAdaptado.fecha.isBefore(o2.pedidoAdaptado.fecha))
		{	return 1	}
		else
		{	return 0	}
	}
}