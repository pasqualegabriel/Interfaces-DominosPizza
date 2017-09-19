package plato

import pedido.Plato
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Pizza
import java.util.List
import persistencia.Home
import pizza.Ingrediente
import pizza.DistribucionEnPizza
import pizza.Distribucion
import agregarPizza.IngredienteAdapterAbstract

@Accessors
@TransactionalAndObservable
class PlatoAppModel {
	 
	
	double precio
	Plato plato
	List<Pizza> pizzaItems			= newArrayList
	Pizza pizzaSelect
	List<Tamanio> itemsSize 		= newArrayList
	Tamanio sizeSelect
	List<IngredienteAdapterAbstract> ingredientesExtras = newArrayList
    
	
	new(Plato unPlato) {
		coleccionPizzaItems
		coleccionTamanioItems
		plato 			= unPlato
		pizzaSelect		= plato.pizza
		sizeSelect		= itemsSize.findFirst[ t | t.nombre.equalsIgnoreCase(unPlato.tamanio.nombre) ]
		precio = plato.calcularPrecio
		
	}

	def coleccionTamanioItems() {
		itemsSize.addAll(Home.instance.tamanios)

	}

	def coleccionPizzaItems() {
		pizzaItems.addAll(Home.instance.getPromocionesDisponibles())
	}

	def void setPizzaSelect(Pizza unaPizza) {
		pizzaSelect = unaPizza
		
	}

	def void setSizeSelect(Tamanio unTamanio) {
		sizeSelect = unTamanio
		

	}
	
	def agregaIngredienteExtra(Ingrediente ingrediente, DistribucionEnPizza distribucion) {
		plato.agregarIngredienteExtra(ingrediente,distribucion)
		
	}
	
	def cambiarDistribucionDeIngredienteExtra(Ingrediente unIngrediente,DistribucionEnPizza unaDistribucion) {
		plato.cambiarDistribucionDeUnIngrediente(unIngrediente,unaDistribucion)
		
	}
	
	def agregarIngredientes() {
		plato.ingredientesExtras= new Distribucion
		for (IngredienteAdapterAbstract ingrediente: ingredientesExtras){
			ingrediente.agregarse
		}
		
	}
	
	def calcularPrecio() {
		precio = pizzaSelect.precioBase * sizeSelect.factorDeTamanio 
		         + precioDeIngredientesExtras
	}
	
	def getPrecioDeIngredientesExtras() {
		var double precioDeIngredientesExtras = 0
		for(IngredienteAdapterAbstract i: ingredientesExtras){
			precioDeIngredientesExtras += i.getPrecio
		}
		precioDeIngredientesExtras
	}
	def void aceptarCambio(){	
		agregarIngredientes
		plato.pizza = pizzaSelect
		plato.tamanio = sizeSelect

		
	}
	
	
	
	

}













