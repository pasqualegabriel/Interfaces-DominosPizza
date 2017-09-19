package pedido

import org.uqbar.arena.windows.WindowOwner

class PedidoCerradoWindow extends PedidoWindowEditar
{
	
	new(WindowOwner owner, Pedido pedido) 
	{
		super(owner, pedido)
	}
	
	override titulo() 
	{	'''Ver Pedido de «modelObject.pedidoAdaptado.miembro.nombre»'''.toString	}

	
}