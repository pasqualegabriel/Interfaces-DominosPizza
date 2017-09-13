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
class IngredienteAppModel {

	Pizza pizza

	Ingrediente ingrediente

	Boolean estaActivadoEnCheckbox

	DistribucionEnPizza distribucionSeleccionadaParaPizza

	PlatoAdapter platoAdapter

	DistribucionEnPizza distribucionSeleccionadaParaIngredientesExtras

	new(Ingrediente unIngrediente, PlatoAdapter unPlatoAdapter) {
		ingrediente = unIngrediente
		platoAdapter = unPlatoAdapter
		estaActivadoEnCheckbox = platoAdapter.pizzaSelect.distribucion.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionadaParaIngredientesExtras = platoAdapter.pizzaSelect.distribucion.posicionIngrediente(unIngrediente)
		}
	}

	new(Ingrediente unIngrediente, Pizza unaPizza) {
		pizza = unaPizza
		ingrediente = unIngrediente
		estaActivadoEnCheckbox = pizza.distribucion.tieneAlIngrediente(unIngrediente)
		if (estaActivadoEnCheckbox) {
			this.distribucionSeleccionadaParaPizza = pizza.distribucion.posicionIngrediente(unIngrediente)
		}
	}

	def getDistribuciones() {
		#[DistribucionEnPizza.Izquierda, DistribucionEnPizza.Toda, DistribucionEnPizza.Derecha]
	}

	def void setEstaEnLaPizza(Boolean unBool) {
		if (unBool == false && distribucionSeleccionadaParaPizza != null) {
			pizza.quitarIngrediente(ingrediente)
			distribucionSeleccionadaParaPizza = null
		}
		estaActivadoEnCheckbox = unBool

	}


	// Estos ifs no son correctos. Van a desaparecer cuando pueda arreglar el problema
	// De que la checkbox no esta tomando el enabled.
	def void setDistribucionSeleccionadaParaPizza(DistribucionEnPizza unaDistribucion) {
		if (estaActivadoEnCheckbox && distribucionSeleccionadaParaPizza == null) {
			pizza.agregarIngrediente(ingrediente, unaDistribucion)
			distribucionSeleccionadaParaPizza = unaDistribucion
		}
		if (estaActivadoEnCheckbox && distribucionSeleccionadaParaPizza != null) {
			pizza.cambiarDistribucionDe(ingrediente, unaDistribucion)
			distribucionSeleccionadaParaPizza = unaDistribucion
		}

	}

	def void setDistribucionSeleccionadaParaIngredientesExtras(DistribucionEnPizza unaDistribucion) {
		if (estaActivadoEnCheckbox && distribucionSeleccionadaParaIngredientesExtras == null) {
			platoAdapter.agregaIngredienteExtra(ingrediente, unaDistribucion)
			distribucionSeleccionadaParaIngredientesExtras = unaDistribucion
		}
		if (estaActivadoEnCheckbox && distribucionSeleccionadaParaIngredientesExtras != null) {
			platoAdapter.cambiarDistribucionDeIngredienteExtra(ingrediente, unaDistribucion)
			distribucionSeleccionadaParaIngredientesExtras = unaDistribucion
		}

		
			

	}

}
