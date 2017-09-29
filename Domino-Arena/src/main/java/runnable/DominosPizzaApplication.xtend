package runnable

import org.uqbar.arena.Application
import persistencia.Bootstrap

class DominosPizzaApplication extends Application
{
	def static void main(String[] args) 
	{	
		// Se crea el bootstrap, el cual instancia los repos y les agrega unos pocos elementos para tener
		// como contenido.
		var buststrap =new Bootstrap
		buststrap.inicializar
		new DominosPizzaApplication().start()
	}
	
	override protected createMainWindow() 
	{	
		
		new DominosPizzaMainWindow(this, new ImagenDominosPizza())
	
	}
}