package runnable

import org.uqbar.arena.Application

class DominosPizzaApplication extends Application
{
	def static void main(String[] args) 
	{
		new DominosPizzaApplication().start()
	}
	
	override protected createMainWindow() 
	{	
		new DominosPizzaMainWindow(this, new ImagenDominosPizza())
	
	}
}