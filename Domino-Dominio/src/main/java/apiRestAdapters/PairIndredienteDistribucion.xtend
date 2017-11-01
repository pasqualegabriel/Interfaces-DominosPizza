package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Ingrediente

@Accessors
class PairIndredienteDistribucion {
	Ingrediente ingrediente
	String 		distribucion
	new(){}
	
	new(Ingrediente aIngrediente, String aDistribucion){
		ingrediente		= aIngrediente
		distribucion	= aDistribucion
	}
}