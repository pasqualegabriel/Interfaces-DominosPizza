package runnable

import org.uqbar.arena.Application
import persistencia.Bootstrap

class DominosPizzaApplication extends Application
{
	def static void main(String[] args) 
	{
		var buststrap =new Bootstrap
		buststrap.run
		new DominosPizzaApplication().start()
	}
	
	override protected createMainWindow() 
	{	
		
		new DominosPizzaMainWindow(this, new ImagenDominosPizza())
	
	}
}