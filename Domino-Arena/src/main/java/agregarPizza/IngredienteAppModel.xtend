package agregarPizza

import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import pizza.Pizza
import pizza.DistribucionEnPizza

@Observable
@Accessors
@Transactional
class IngredienteAppModel {
	
   Pizza pizza;
  
   Ingrediente ingrediente;
  
   Boolean estaEnLaPizza;
  
   DistribucionEnPizza distribucionSeleccionada;
	
	new(Ingrediente unIngrediente, Pizza unaPizza) {
		pizza = unaPizza
   		ingrediente = unIngrediente
    	estaEnLaPizza = pizza.distribucion.tieneAlIngrediente(unIngrediente)
	    if (estaEnLaPizza) {
			this.distribucionSeleccionada = pizza.distribucion.posicionIngrediente(unIngrediente)
		}
	}
	def getDistribuciones(){
		#[DistribucionEnPizza.Izquierda, DistribucionEnPizza.Toda, DistribucionEnPizza.Derecha]  
	}
	
	
	def void setEstaEnLaPizza( Boolean unBool) {
		if (unBool == false && distribucionSeleccionada != null){
			pizza.quitarIngrediente(ingrediente) 
			distribucionSeleccionada = null
		}
		estaEnLaPizza= unBool
		
	}
	
	// Estos ifs no son correctos. Van a desaparecer cuando pueda arreglar el problema
	// De que la checkbox no esta tomando el enabled.
	def void setDistribucionSeleccionada(DistribucionEnPizza unaDistribucion) {
		if (estaEnLaPizza && distribucionSeleccionada == null){
			pizza.agregarIngrediente(ingrediente, unaDistribucion)
			distribucionSeleccionada= unaDistribucion
		}
		if (estaEnLaPizza && distribucionSeleccionada != null){
			pizza.cambiarDistribucionDe(ingrediente,unaDistribucion)
			distribucionSeleccionada= unaDistribucion
		}
		
	}
	
	
}