package listadoDePedidosCerrados

import org.uqbar.arena.Application

class WindowAppListaPedidosCerrados extends Application
{
	def static void main(String[] args) 
	{
		new WindowAppListaPedidosCerrados().start()
	}
	
	/*Llama a la ventana Principal que se encarga de mostrar todo*/
	override protected createMainWindow() 
	{
		new MainWindowListaPedidosCerrados(this)
	}
}