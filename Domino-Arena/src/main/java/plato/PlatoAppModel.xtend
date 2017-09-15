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


@Accessors
@TransactionalAndObservable
class PlatoAppModel {
	 
	
	String precio
	Plato plato
	List<Pizza> pizzaItems = newArrayList
	Pizza pizzaSelect
	List<Tamanio> itemsSize = newArrayList
	Tamanio sizeSelect
	
	
	new(Plato unPlato) {
		plato = unPlato
		pizzaSelect = plato.pizza
		sizeSelect = plato.tamanio
		precio = "$" + plato.calcularPrecio
		coleccionPizzaItems
		coleccionTamanioItems
	}

	def coleccionTamanioItems() {
		itemsSize.addAll(Home.instance.tamanios)

	}

	def coleccionPizzaItems() {
		pizzaItems.addAll(Home.instance.getPromocionesDisponibles())
	}

	def void setPizzaSelect(Pizza unaPizza) {
		pizzaSelect = unaPizza
		plato.pizza =unaPizza
		setPrecio
	}

	def void setSizeSelect(Tamanio unTamanio) {
		sizeSelect = unTamanio
		plato.tamanio = unTamanio
		setPrecio

	}

	def void setPrecio() {
		if (!pizzaSelect.equals(null) && !sizeSelect.equals(null) && !plato.ingredientesExtras.equals(null)){
			var double costoTotal=pizzaSelect.precioBase * sizeSelect.factorDeTamanio + plato.ingredientesExtras.costoDeIngredientes
			precio = "$" + costoTotal
			
		}
	}
	
	def agregaIngredienteExtra(Ingrediente ingrediente, DistribucionEnPizza distribucion) {
		plato.agregarIngredienteExtra(ingrediente,distribucion)
		setPrecio
	}
	
	def cambiarDistribucionDeIngredienteExtra(Ingrediente unIngrediente,DistribucionEnPizza unaDistribucion) {
		plato.cambiarDistribucionDeUnIngrediente(unIngrediente,unaDistribucion)
		
	}

}