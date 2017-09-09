package listadoDePedidos

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import java.util.List
import persistencia.Home
import org.uqbar.commons.model.annotations.Dependencies

@Observable
@Accessors
class PedidosAppModel {

	Home repoHome
	List<AdapterPedido> pedidos = newArrayList
	AdapterPedido pedidoSeleccionado
	int nroPedido = 1

//	String nombre
//	EstadoDePedido estado
//	int monto
//	LocalTime hora
	new(Home nuevoRepoHome) {
		super()
		repoHome = nuevoRepoHome
		for (Pedido pedido : repoHome.pedidosAbiertos) {
			pedidos.add(new AdapterPedido(pedido, nroPedido))
			nroPedido++
		
		}
//		pedidoSeleccionado = new Pedido(new Miembro)
//		estado = new Entregado
//		monto  = 10
//		hora   = LocalTime.of(12,12)
	}
	

	def cancelarPedidoSeleccionado() {

		pedidoSeleccionado.cancelar
		pedidos.remove(pedidoSeleccionado)
		pedidoSeleccionado = null
	}

}
