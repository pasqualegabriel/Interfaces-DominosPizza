package agregarPizza

import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import pizza.Pizza
import pizza.DistribucionEnPizza
import plato.PlatoAdapter

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

	override void setEstaActivadoEnCheckbox(Boolean unBool) {
		if (unBool == false && distribucionSeleccionada != null) {
			pizza.quitarIngrediente(ingrediente)
			distribucionSeleccionada = null
		}
		estaActivadoEnCheckbox = unBool

	}
	
	override cambiarDistribucion(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion) {
		pizza.cambiarDistribucionDe(ingrediente, unaDistribucion)
	}
	
	override agregarIngrediente(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion) {
		pizza.agregarIngrediente(ingrediente, unaDistribucion)
	}



		
			

}


