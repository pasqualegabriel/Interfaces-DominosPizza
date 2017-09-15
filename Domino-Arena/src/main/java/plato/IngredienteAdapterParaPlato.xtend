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
	
	PlatoAppModel platoAdapter

	new(Ingrediente unIngrediente, PlatoAppModel unPlatoAdapter) {
		super(unIngrediente)	
		platoAdapter = unPlatoAdapter
		estaActivadoEnCheckbox = platoAdapter.pizzaSelect.distribucion.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionada = platoAdapter.pizzaSelect.distribucion.posicionIngrediente(unIngrediente)
		}
	}
	
	override void setEstaActivadoEnCheckbox(Boolean unBool) {
		if (!unBool && distribucionSeleccionada != null) {
			platoAdapter.plato.quitarIngredienteExtra(ingrediente)
			distribucionSeleccionada = null
		}
		estaActivadoEnCheckbox = unBool

	}
	
	override agregarseAPizza() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}