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

	/**Trae la lista de pedidos abiertos ordenados por hora de pedido*/
	def getRepoDePedidosAbiertos() {
		this.itemsPedidosAbiertos = ordenarListaDePedidos(itemsPedidosAbiertos, new ComparatorHoraPedidosAscendente)
	}

	/**Trae la lista de pedidos cerrados ordenados por fecha de pedido*/
	def getRepoDePedidosCerrados() {
		this.itemsPedidosCerrados = ordenarListaDePedidos(itemsPedidosCerrados, new ComparatorFechaPedidosDescendente)
	}

	/** Cancela un pedido seleccinado y lo pasa a la lista de pedidos cerrados */
	def void cancelarPedidoSeleccionado() {
		pedidoSelectItem.cancelar()
		this.cerrarPedidoSeleccionado
	}

	/**Pasa el pedido al siguiente estado */
	@Dependencies("itemsPedidosAbiertos")
	def void siguienteEstadoPedidoSeleccionado() {
		pedidoSelectItem.siguiente
		/*verifica si el pedido pasa a un pedido entregado,
		 *  si es asi lo cierra y lo envia a pedido cerrados*/
		if (pedidoSelectItem.estadoActual.nombre.equalsIgnoreCase("Entregado"))
			this.cerrarPedidoSeleccionado
		else
			this.repoDePedidosAbiertos
	}

	/**Pasa el pedido al anterior estado */
	@Dependencies("itemsPedidosAbiertos")
	def void anteriorEstadoPedidoSeleccionado() {
		/*verifica si el pedido no es el estado preparando. Si
		 * es asi pasa al estado anterior, sino levanta una excepcion avisando
		 * que no se puede pasar*/		
		if (!pedidoSelectItem.estadoActual.nombre.equals("Preparando")) {
			pedidoSelectItem.anterior
			this.repoDePedidosAbiertos
		} else {
			throw new StateException("No se puede ir a un estado atras estas en el inicial")
		}
	}

	/**Cierra un pedido seleccionado */
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

/**Clase comparator creada para poder ordenar por hora los pedidos. 
 * Se ordena de la siguiente manera:
 * -Hora de o1 es menor a la hora de o2 retorna -1
 * -Hora de o1 es mayor a la hora de o2 retorna 1
 * -Hora de o1 es igual a la hora de o2 retorna 0*/
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

/**Clase comparator creada para poder ordenar por Fecha los pedidos. 
 * Se ordena de la siguiente manera:
 * -Fecha de o1 es menor a la Fecha de o2 retorna -1
 * -Fecha de o1 es mayor a la Fecha de o2 retorna 1
 * -Fecha de o1 es igual a la Fecha de o2 retorna 0*/
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
