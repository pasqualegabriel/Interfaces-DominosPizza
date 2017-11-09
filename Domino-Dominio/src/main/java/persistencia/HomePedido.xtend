package persistencia

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pedido.Pedido
import org.apache.commons.lang.StringUtils
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class HomePedido {

	static HomePedido instance


	static def getInstance() {
		if (instance == null) {
			instance = new HomePedido
		}
		instance
	}

	// Estructura
	List<Pedido> pedidosAbiertos = newArrayList
	List<Pedido> pedidosCerrados = newArrayList
	Integer	id					 = 0;

	// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	def agregarPedido(Pedido unPedido) {
		if (pedidosAbiertos.stream.anyMatch[it.id.equals(unPedido.id)]) throw new UserException("El Pedido Ya Existe")
		pedidosAbiertos.add(unPedido)

	}

	def void moverPedidoAPedidosCerrado(Pedido unPedido) {
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}
	
	def searchPedidoPorEstado(String nombreDeEstado) 
	{
		if (StringUtils.isBlank(nombreDeEstado)) 
		{	this.pedidosAbiertos	}
		else 
		{	this.pedidosAbiertos.filter[ it.estadoActual.nombre.toLowerCase.replaceAll(" ","").equalsIgnoreCase(nombreDeEstado)].toList	}
	}
	
	def Pedido getPedido(Integer integer) {
		pedidosAbiertos.findFirst[ it.id.equals(integer) ]
	}
	
	def searchPedidosPorNickUsuario(String nickDeUsuario) {
		if (StringUtils.isBlank(nickDeUsuario)) 
		{	throw new UserException("el string no tiene que estar vacio")	}
		else 
		{	HomeMiembro.instance.getMiembro(nickDeUsuario).listaHistorialDePedidos}
	}
	
	def newId(){
		var retornarId = id
		id++
		
		retornarId;
	}
	
	def deleteAll() {
		pedidosAbiertos = newArrayList
		pedidosCerrados = newArrayList
		id					 = 0;
	}
	
}
