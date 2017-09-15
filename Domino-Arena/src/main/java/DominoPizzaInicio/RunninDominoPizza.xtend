package DominoPizzaInicio

import org.uqbar.arena.Application


class RunninDominoPizza  extends Application{

	
	def static void main(String[] args) 
	{
		new RunninDominoPizza().start()
	}
	
	override protected createMainWindow() 
	{	
		new DominoPizzaWindow(this,new DominoPizzaAppModel)
	}
		
}
