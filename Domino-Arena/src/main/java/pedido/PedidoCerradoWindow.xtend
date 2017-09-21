package pedido

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label

class PedidoCerradoWindow extends PedidoWindowEditar
{
	new(WindowOwner owner, Pedido pedido) 
	{	super(owner, pedido)	}
	
	override titulo() 
	{	'''Ver Pedido de «modelObject.pedidoAdaptado.miembro.nombre»'''.toString	}

	override selectorDeEstado(Panel panelEstados) 
	{	new Label(panelEstados) => [	value <=>  "cambioDeEstado.nombre"	]	}

	override aclaracion(Panel mainPanel)
	{	new Label(mainPanel) => [	value <=>  "pedidoAdaptado.aclaracion"	]	}	
}
