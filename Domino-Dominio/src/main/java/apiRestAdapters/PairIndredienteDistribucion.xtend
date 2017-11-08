package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Ingrediente
import pizza.PairIngredienteDistribucionPizza
import pizza.DistribucionEnPizza

@Accessors
class PairIndredienteDistribucion {
	Ingrediente ingrediente
	String 		distribucion
	new(){}
	
	new(Ingrediente aIngrediente, String aDistribucion){
		ingrediente		= aIngrediente
		distribucion	= aDistribucion
	}
	
	def convertir() {
		new PairIngredienteDistribucionPizza(ingrediente,DistribucionEnPizza.valueOf(distribucion))
	}
	
}