package plato

import agregarPizza.IngredienteAdapterAbstract
import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable


@Accessors
@TransactionalAndObservable
class IngredienteExtraAppModel extends IngredienteAdapterAbstract {
	
	PlatoAppModel platoapp
	
	new(PlatoAppModel unPlato, Ingrediente unIngrediente) {
		super(unIngrediente)
		platoapp = unPlato
		estaActivadoEnCheckbox = platoapp.plato.ingredientesExtras.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionada =  platoapp.plato.ingredientesExtras.posicionIngrediente(unIngrediente)
		}
		
	}
	
	
	// cuando le mandas calcularPrecio, lo que hace es hacer una distribucionTemporalNueva, 
	// recorre todos los ingredientesExtrraAppModel, agrega a los locos que cumplen con la condicion
	// de que estaactivadoEnCheckbox y distribucionSeleccionada diferente a null
	// y los agrega a la distribuciontemportal
	// calcula el precio con esa distro temporal.
	override agregarse() {
		if( estaActivadoEnCheckbox && distribucionSeleccionada != null){
			platoapp.plato.agregarIngredienteExtra(ingrediente,distribucionSeleccionada)

		}
	}
	
}