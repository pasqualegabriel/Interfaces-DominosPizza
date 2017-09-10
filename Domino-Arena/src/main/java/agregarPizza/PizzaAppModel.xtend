package agregarPizza

import pizza.Pizza
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Distribucion
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class PizzaAppModel{
	
	Pizza 						 pizza
	Distribucion	        	distribucion
	String						distribucionSeleccionada
	
	
	new(Pizza unaPizza) {
		super()
		
	}
	
	def getTieneIngrediente() {
			true
	}
	

	
	def getNombre() {
		pizza.nombre
	}
	
	def getPrecioBase() {
		pizza.precioBase
	}
	
}