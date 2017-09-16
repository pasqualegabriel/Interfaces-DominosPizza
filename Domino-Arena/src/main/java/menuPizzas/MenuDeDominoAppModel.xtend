package menuPizzas
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import persistencia.Home
import java.util.List

@Observable
@Accessors
class MenuDeDominoAppModel {
	
	Home home
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado	
	List<Ingrediente> ingredientesDisponibles
	List<Pizza> promosDisponibles
	
	
	new(){
		home= Home.instance
		ingredientesDisponibles = home.getIngredientesDisponibles
		promosDisponibles = home.getPromocionesDisponibles
	}
	
	def agregarIngrediente(Ingrediente unIngrediente){
		
	    ingredientesDisponibles.add(unIngrediente)
	}
	
	def agregarPromocion(Pizza unaPizza){
		
	 	promosDisponibles.add(unaPizza)
	}
	
	def eliminarIngrediente(Ingrediente unIngrediente) {
	
		ingredientesDisponibles.remove(unIngrediente)
	}
	
	def eliminarPizza(Pizza unaPizza) {
		
		promosDisponibles.remove(unaPizza)
	}
	
//		Deberia ser asi, pero no anda!
//
//	def getIngredientesDisponibles(){
//		home.getIngredientesDisponibles
//	}
//
//	def getPromosDisponibles(){
//		home.getPromocionesDisponibles
//	}
	
}