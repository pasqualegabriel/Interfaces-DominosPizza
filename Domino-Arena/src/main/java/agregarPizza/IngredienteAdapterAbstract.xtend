package agregarPizza

import pizza.Ingrediente
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Transactional

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
	
	// Estos ifs no son correctos. Van a desaparecer cuando pueda arreglar el problema
	// De que la checkbox no esta tomando el enabled.
	def void setDistribucionSeleccionada(DistribucionEnPizza unaDistribucion) {
		if (estaActivadoEnCheckbox && distribucionSeleccionada == null) {
			this.agregarIngrediente(ingrediente, unaDistribucion)
			distribucionSeleccionada = unaDistribucion
		}
		if (estaActivadoEnCheckbox && distribucionSeleccionada != null) {
			this.cambiarDistribucion(ingrediente, unaDistribucion)
			distribucionSeleccionada = unaDistribucion
		}

	}
	
	def void cambiarDistribucion(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion)
	
	def void agregarIngrediente(Ingrediente ingrediente, DistribucionEnPizza unaDistribucion)
	
}