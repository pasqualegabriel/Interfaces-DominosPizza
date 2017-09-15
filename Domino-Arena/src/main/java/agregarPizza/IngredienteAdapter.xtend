package agregarPizza

import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import pizza.Pizza
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Dependencies

@Observable
@Accessors
@Transactional
class IngredienteAdapter extends IngredienteAdapterAbstract {

	Pizza pizza

	new(Ingrediente unIngrediente, Pizza unaPizza) {
		super(unIngrediente)
		pizza = unaPizza
		estaActivadoEnCheckbox = pizza.distribucion.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionada = pizza.distribucion.posicionIngrediente(unIngrediente)
		}
		
	}
	
	override agregarseAPizza() {
		if(estaActivadoEnCheckbox && distribucionSeleccionada != null){
			pizza.distribucion.agregarIngrediente(ingrediente, distribucionSeleccionada)
		}
	}

}


