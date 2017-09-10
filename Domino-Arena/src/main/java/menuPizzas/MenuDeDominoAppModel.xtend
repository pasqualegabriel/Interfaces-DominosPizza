package menuPizzas
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import pizza.Distribucion
import java.util.List
import java.util.ArrayList

@Observable
@Accessors
class MenuDeDominoAppModel {
	
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado
	List<Pizza> promosDisponibles = new ArrayList<Pizza>
	List<Ingrediente> ingredientesDisponibles = new ArrayList<Ingrediente>
	
	new(){
		promosDisponibles.add(new Pizza("Muzzarela Grande", 30, new Distribucion))
		promosDisponibles.add(new Pizza("Anana", 60, new Distribucion))
		ingredientesDisponibles.add(new Ingrediente("Peperoni",3))
		ingredientesDisponibles.add(new Ingrediente("Banana",4))
	}
	
	def agregarIngrediente(Ingrediente unIngrediente){
		ingredientesDisponibles.add(unIngrediente)	
	}
	
	def agregarPromocion(Pizza unaPizza){
		promosDisponibles.add(unaPizza)
	}
	
	def eliminarIngrediente(Ingrediente ingrediente) {
		ingredientesDisponibles.remove(ingrediente)
	}
	
	def eliminarPizza(Pizza pizza) {
		promosDisponibles.remove(pizza)
	}
	
}