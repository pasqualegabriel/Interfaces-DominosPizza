package plato

import agregarPizza.IngredienteAdapterAbstract
import pizza.Ingrediente
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Transactional

@Observable
@Accessors
@Transactional
class IngredienteAdapterParaPlato extends IngredienteAdapterAbstract {
	
	PlatoAdapter platoAdapter

	new(Ingrediente unIngrediente, PlatoAdapter unPlatoAdapter) {
		super(unIngrediente)	
		platoAdapter = unPlatoAdapter
		estaActivadoEnCheckbox = platoAdapter.pizzaSelect.distribucion.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionada = platoAdapter.pizzaSelect.distribucion.posicionIngrediente(unIngrediente)
		}
	}
	
	override cambiarDistribucion(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion) {
		platoAdapter.agregaIngredienteExtra(ingrediente, unaDistribucion)
	}
	
	override agregarIngrediente(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion) {
		platoAdapter.cambiarDistribucionDeIngredienteExtra(ingrediente, unaDistribucion)
	}
	
}