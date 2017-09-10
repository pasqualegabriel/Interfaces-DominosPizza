package listadoDePedidos

import org.uqbar.arena.Application
import persistencia.Home

class PedidoWindowApp extends Application{


	def static void main(String[] args) {
		new PedidoWindowApp().start()
	}
	
	override protected createMainWindow() {
		
		val home	= Home.instance
		val modelo = new PedidosAppModel(home) => [
			
		]
		new PedidosMainWindow(this, modelo) 
	}
		
}
