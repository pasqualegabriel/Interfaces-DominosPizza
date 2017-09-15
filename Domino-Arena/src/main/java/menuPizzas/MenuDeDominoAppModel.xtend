package menuPizzas
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import persistencia.Home

@Observable
@Accessors
class MenuDeDominoAppModel {
	
	Home home
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado	
	
	// Remplazar creaciones por el home
	new(){
		home= Home.instance
	}
	
	def agregarIngrediente(Ingrediente unIngrediente){
		home.agregarIngrediente(unIngrediente)
	}
	
	def agregarPromocion(Pizza unaPizza){
		home.agregarPromocion(unaPizza)
	}
	
	def eliminarIngrediente(Ingrediente unIngrediente) {
		home.borrarIngrediente(unIngrediente)
	}
	
	def eliminarPizza(Pizza unaPizza) {
		home.borrarPromocion(unaPizza)
	}
	
	def getIngredientesDisponibles(){
		home.getIngredientesDisponibles()
	}
	
	def getPromosDisponibles(){
		home.getPromocionesDisponibles
	}
	
}