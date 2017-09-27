package pedido

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label

class PedidoCerradoWindow extends PedidoWindowEditar
{
	new(WindowOwner owner, Pedido pedido) 
	{	super(owner, pedido)	}
	
	/**Redefine el titulo para que sea acorde a la ventana de pedidos Cerrados */
	override titulo() 
	{	'''Ver Pedido de «modelObject.pedidoAdaptado.miembro.nombre»'''.toString	}

	/**Redefine el selector de estados para que sea solo un label */
	override selectorDeEstado(Panel panelEstados) 
	{	new Label(panelEstados) => [	value <=>  "cambioDeEstado.nombre"	]	}

	/**Redefine el textbox de aclaraciones para que sea solo un label */
	override aclaracion(Panel mainPanel)
	{	new Label(mainPanel) => [	value <=>  "pedidoAdaptado.aclaracion"	]	}	
}
