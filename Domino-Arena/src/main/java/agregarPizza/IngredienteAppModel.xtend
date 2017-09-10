package agregarPizza

import pizza.Ingrediente

class IngredienteAppModel {
	
	Ingrediente ingrediente
	Boolean estaEnLaPizza 
	Enum distribucion
	
	new(Ingrediente unIngrediente) {
		ingrediente = unIngrediente
	}
	
}