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

	new(Home nuevoRepoHome) {
		super()
		repoHome = nuevoRepoHome
		for (Pedido pedido : repoHome.pedidosAbiertos) {
			pedidos.add(new AdapterPedido(pedido, nroPedido))
			nroPedido++
		
		}
	}
	
	
	@Dependencies("pedidos")
	def cancelarPedidoSeleccionado() {
		pedidoSeleccionado.cancelar
		pedidos.remove(pedidoSeleccionado)
		pedidoSeleccionado = null
	}
	
	@Dependencies("pedidos")
	def void siguienteEstado(){
		pedidoSeleccionado.siguienteEstado
		System.out.println(pedidoSeleccionado.estadoActual)
	}
	
	@Dependencies("pedidos")
	def void anteriorEstado(){
		pedidoSeleccionado.anteriorEstado
		System.out.println(pedidoSeleccionado.estadoActual)
	}
	
	

}
