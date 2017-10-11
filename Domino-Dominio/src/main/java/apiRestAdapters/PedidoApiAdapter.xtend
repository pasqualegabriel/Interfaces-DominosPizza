package apiRestAdapters

import pedido.Pedido
import java.util.List
import pedido.Plato
import pedido.FormaDeRetiro
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class PedidoApiAdapter 
{

	String 			estadoActual
	String			miembro
	List<Plato> 	platos 
	String 			fecha
	String 			aclaracion
	FormaDeRetiro 	formaDeRetiro
	Double			monto

	new (Pedido unPedido)
	{
		estadoActual	= unPedido.estadoActual.nombre
		miembro			= unPedido.miembro.nombre
		platos			= unPedido.platos 
		fecha			= unPedido.fecha.toLocalDate.toString + " " + unPedido.fecha.toLocalTime.toString //'''«unPedido.fecha.toLocalDate» «unPedido.fecha.toLocalTime»'''
		aclaracion		= unPedido.aclaracion
		formaDeRetiro	= unPedido.formaDeRetiro
		monto			= unPedido.precio
	}	
}