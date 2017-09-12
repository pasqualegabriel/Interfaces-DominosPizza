package listadoDePedidos

import org.uqbar.arena.Application

class PedidoWindowApp extends Application
{
	def static void main(String[] args) 
	{
		new PedidoWindowApp().start()
	}
	
	override protected createMainWindow() 
	{	
		new PedidosMainWindow(this)
	}
		
}
