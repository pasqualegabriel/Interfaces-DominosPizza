package menuPizzas
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import java.util.List
import persistencia.HomePizza
import persistencia.HomeIngrediente


@Observable
@Accessors
class MenuDeDominoAppModel {
	
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado	
	List<Ingrediente> ingredientesDisponibles
	List<Pizza> promosDisponibles
	
	
	new(){
		ingredientesDisponibles = HomeIngrediente.instance.ingredientesDisponibles
		promosDisponibles = HomePizza.instance.promocionesDisponibles
	}
	
	def agregarIngrediente(Ingrediente unIngrediente){
		HomeIngrediente.instance.agregarIngrediente(unIngrediente)
	  
	}
	
		def eliminarIngrediente(Ingrediente unIngrediente) {
		HomeIngrediente.instance.borrarIngrediente(unIngrediente)
		
	}
	def agregarPromocion(Pizza unaPizza){
		 HomePizza.instance.agregarPromocion(unaPizza)
	 	
	}
	def eliminarPizza(Pizza unaPizza) {
		 HomePizza.instance.borrarPromocion(unaPizza)
	}
	
	def void actualizarPromosDisponibles()
	{
		promosDisponibles = null
		promosDisponibles = HomePizza.instance.promocionesDisponibles
	}
	
	def actualizarIngredientesDisponibles() {
		ingredientesDisponibles = null
		ingredientesDisponibles = HomeIngrediente.instance.ingredientesDisponibles
	}
	
	
}