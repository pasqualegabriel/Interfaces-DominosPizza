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
class MenuDeDominoAppModel 
{
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado	
	List<Ingrediente> ingredientesDisponibles
	List<Pizza> promosDisponibles
	
	
	new()
	{
		ingredientesDisponibles = HomeIngrediente.instance.todosLosIngredientes
		promosDisponibles 		= HomePizza.instance.promocionesDisponibles
	}
	
	/**Agrega un ingrediente al repositorio de ingredientes y actualiza la lista de ingredientes disponibles */
	def agregarIngrediente(Ingrediente unIngrediente)
	{
		HomeIngrediente.instance.agregarIngrediente(unIngrediente)
		actualizarIngredientesDisponibles
	}
	
	/**Elimina un ingrediente del repositorio de ingredientes y actualiza la lista de ingredientes disponibles */
	def eliminarIngrediente(Ingrediente unIngrediente) 
	{
		HomeIngrediente.instance.borrarIngrediente(unIngrediente)
		actualizarIngredientesDisponibles
	}
	
	/**Agrega una pizza al repositorio de pizzas y actualiza la lista de promociones disponibles*/
	def agregarPromocion(Pizza unaPizza)
	{
		 HomePizza.instance.agregarPromocion(unaPizza)
		 actualizarPromosDisponibles
	}
	
	/**Elimina una pizza del repositorio de pizzas y actualiza la lista de promociones disponibles*/
	def eliminarPizza(Pizza unaPizza) 
	{
		 HomePizza.instance.borrarPromocion(unaPizza)
		 actualizarPromosDisponibles
	}
	
	/**Actualiza las promos disponibles con las promociones actuales */
	def void actualizarPromosDisponibles()
	{
		promosDisponibles = HomePizza.instance.todasLasPromociones
	}
	
	/**Actualiza los ingredientes disponibles con los ingredientes actuales */
	def actualizarIngredientesDisponibles() 
	{
		ingredientesDisponibles = HomeIngrediente.instance.todosLosIngredientes
	}
	
	
}