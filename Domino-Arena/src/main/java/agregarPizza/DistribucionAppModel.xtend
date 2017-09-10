package agregarPizza

import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import pizza.Pizza
import pizza.DistribucionEnPizza

@Accessors
@Observable
class DistribucionAppModel {
	Pizza 	    pizza
	Ingrediente ingrediente
	Boolean     tieneIngrediente
	DistribucionEnPizza      distribucionSeleccionada
	
	new(Ingrediente unIngrediente, Pizza unaPizza) {
		ingrediente= unIngrediente
		tieneIngrediente = false
	}
	
	def getNombre(){
		ingrediente.nombre
	}
	
	def getDistribuciones() {
		
	   #[DistribucionEnPizza.Izquierda, DistribucionEnPizza.Toda, DistribucionEnPizza.Derecha]  
	}
	
	def void setTieneIngrediente(Boolean unBool){
		if (unBool==false && distribucionSeleccionada != null){
			pizza.distribucion.quitarIngrediente(ingrediente)	
		}
		tieneIngrediente=unBool
	}
	
	def void setDistribucionSeleccionada(DistribucionEnPizza unaDistribucion){
		if(pizza.distribucion.tieneAlIngrediente(ingrediente)){
			pizza.distribucion.cambiarDistribucionDe(ingrediente,unaDistribucion)
		}
		else{
			pizza.distribucion.agregarIngrediente(ingrediente, unaDistribucion)
		}
		
	}
	
}