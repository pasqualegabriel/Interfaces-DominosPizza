package agregarPizza

import pizza.Pizza
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pizza.Ingrediente
import java.util.ArrayList
import pizza.Distribucion
import pizza.DistribucionEnPizza
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