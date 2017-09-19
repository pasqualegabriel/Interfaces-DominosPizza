package DominoPizzaInicio

import org.uqbar.arena.Application
import persistencia.Bootstrap

// Esta clase hay que borrarla
class RunninDominoPizza  extends Application{

	
	def static void main(String[] args) 
	{
		var buststrap =new Bootstrap
		buststrap.run
		new RunninDominoPizza().start()
	}
	
	override protected createMainWindow() 
	{	
		new DominoPizzaWindow(this,new DominoPizzaAppModel)
	}
		
}
