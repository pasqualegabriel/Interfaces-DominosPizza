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
		promosDisponibles 		= HomePizza.instance.promocionesDisponibles
	}
	
	def agregarIngrediente(Ingrediente unIngrediente){
		HomeIngrediente.instance.agregarIngrediente(unIngrediente)
		actualizarIngredientesDisponibles
	  
	}
	
	def eliminarIngrediente(Ingrediente unIngrediente) {
		HomeIngrediente.instance.borrarIngrediente(unIngrediente)
		actualizarIngredientesDisponibles
		
	}
	def agregarPromocion(Pizza unaPizza){
		 HomePizza.instance.agregarPromocion(unaPizza)
		 actualizarPromosDisponibles
	 	
	}
	def eliminarPizza(Pizza unaPizza) {
		 HomePizza.instance.borrarPromocion(unaPizza)
		 actualizarPromosDisponibles
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