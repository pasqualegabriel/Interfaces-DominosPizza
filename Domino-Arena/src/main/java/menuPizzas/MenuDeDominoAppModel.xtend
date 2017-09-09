package menuPizzas
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import pizza.Distribucion

@Observable
@Accessors
class MenuDeDominoAppModel {
	
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado
	
	def getPromosDisponibles(){
		// Esto lo redefinimos apenas tengamos decidido como vamos a hacer con la Home/DAO/Repo
		// Esta asi para probar que anda, nada mas.
		val pizza1= new Pizza("Muzzarela Grande", 30, new Distribucion)
		val pizza2= new Pizza("Anana", 60, new Distribucion)
		
		#[pizza1, pizza2]
		
	}
	
	def getIngredientesDisponibles(){
		val pizza1= new Ingrediente("Peperoni",3)
		val pizza2= new Ingrediente("Banana",4)
		
		#[pizza1, pizza2]
		
	}
}