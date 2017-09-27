package plato


import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import edicionDePromocion.IngredienteAdapterAbstract

@Accessors
@TransactionalAndObservable
class IngredienteExtraAppModel extends IngredienteAdapterAbstract {
	
	PlatoAppModel platoapp
	
	new(PlatoAppModel unPlato, Ingrediente unIngrediente) {
		super(unIngrediente)
		platoapp = unPlato
		activado = platoapp.plato.ingredientesExtras.tieneAlIngrediente(unIngrediente)
		if (activado) {
			this.distribucionSeleccionada =  platoapp.plato.ingredientesExtras.posicionIngrediente(unIngrediente)
		}
		
	}
	
	override agregarse() {
		if( activado && distribucionSeleccionada != null){
			platoapp.plato.agregarIngredienteExtra(ingrediente,distribucionSeleccionada)

		}
	}
	
}