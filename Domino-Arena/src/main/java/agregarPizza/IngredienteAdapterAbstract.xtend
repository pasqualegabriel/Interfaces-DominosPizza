package agregarPizza

import pizza.Ingrediente
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Transactional
import org.uqbar.commons.model.annotations.Dependencies

@Observable
@Accessors
@Transactional
abstract class IngredienteAdapterAbstract {
	
	protected Ingrediente ingrediente

	protected Boolean estaActivadoEnCheckbox

	protected DistribucionEnPizza distribucionSeleccionada
	
	
	new (Ingrediente unIngrediente){
		ingrediente = unIngrediente
	}
	
	def getDistribuciones() {
		#[DistribucionEnPizza.Izquierda, DistribucionEnPizza.Toda, DistribucionEnPizza.Derecha]
	}
	
	def void agregarseAPizza() 
}