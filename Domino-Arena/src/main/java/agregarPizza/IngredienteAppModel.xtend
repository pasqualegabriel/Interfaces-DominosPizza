package agregarPizza

import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Distribucion

@Accessors
class IngredienteAppModel {
	
	Ingrediente ingrediente
	Boolean estaEnLaPizza 
	Distribucion distribucion
	
	new(Ingrediente unIngrediente) {
		ingrediente = unIngrediente
	}
	
}