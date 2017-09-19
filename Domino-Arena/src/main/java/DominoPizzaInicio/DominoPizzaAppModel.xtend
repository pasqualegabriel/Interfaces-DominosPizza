package DominoPizzaInicio

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.util.Comparator
import pedido.Pedido
import persistencia.HomePedido

@TransactionalAndObservable
@Accessors
class DominoPizzaAppModel {
	List<Pedido> itemsPedidosAbiertos = HomePedido.instance.pedidosAbiertos
	Pedido pedidoSelectItem
	List<Pedido> itemsPedidosCerrados = HomePedido.instance.pedidosCerrados

	/**Sirve para traer todos los pedidos pasarlo a un adapterPedido y luego guardarlo en una lista */
	def getRepoDePedidosAbiertos() {
		this.itemsPedidosAbiertos = ordenarListaDePedidos(itemsPedidosAbiertos, new ComparatorHoraPedidosAscendente)
	}

	/**Trae la lista de pedidos cerrados*/
	def getRepoDePedidosCerrados() {
		this.itemsPedidosCerrados = ordenarListaDePedidos(itemsPedidosCerrados, new ComparatorFechaPedidosDescendente)
	}

	/** Cancela un pedido seleccinado */
	def void cancelarPedidoSeleccionado() {
		pedidoSelectItem.cancelar()
		this.cerrarPedidoSeleccionado
	}

	/**Pasa al siguiente estado */
	@Dependencies("itemsPedidosAbiertos")
	def void siguienteEstadoPedidoSeleccionado() {
		pedidoSelectItem.siguiente
		if (pedidoSelectItem.estadoActual.nombre.equalsIgnoreCase("Entregado"))
			this.cerrarPedidoSeleccionado
		else
			this.repoDePedidosAbiertos
	}

	/**Pasa al anterior estado */
	@Dependencies("itemsPedidosAbiertos")
	def void anteriorEstadoPedidoSeleccionado() {
		if (!pedidoSelectItem.estadoActual.nombre.equals("Preparando")) {
			pedidoSelectItem.anterior
			this.repoDePedidosAbiertos
		} else {

			throw new StateException("No se puede ir a un estado atras estas en el inicial")
		}

	}

	/**cierra un pedido seleccionado */
	@Dependencies("listaDePedidosAbiertos")
	def void cerrarPedidoSeleccionado() 
	{
		HomePedido.instance.moverPedidoAPedidosCerrado(this.pedidoSelectItem)
		itemsPedidosAbiertos.remove(pedidoSelectItem)
		pedidoSelectItem = null
	}

	/**ordena la lista de pedidos cerrados */
	def ordenarListaDePedidos(List<Pedido> listaActualizada, Comparator<Pedido> uncomparator) {
		if (!listaActualizada.isEmpty || (listaActualizada.size > 1)) {
			listaActualizada.sort(uncomparator)
		}
		listaActualizada
	}

}

class ComparatorHoraPedidosAscendente implements Comparator<Pedido> {
	override compare(Pedido o1, Pedido o2) {
		if (o1.fecha.toLocalTime < o2.fecha.toLocalTime) {
			return -1
		} else if (o1.fecha.toLocalTime > o2.fecha.toLocalTime) {
			return 1
		} else {
			return 0
		}
	}
}

class ComparatorFechaPedidosDescendente implements Comparator<Pedido> {
	override compare(Pedido o1, Pedido o2) {
		if (o1.fecha.isAfter(o2.fecha)) {
			return -1
		} else if (o1.fecha.isBefore(o2.fecha)) {
			return 1
		} else {
			return 0
		}
	}
}
