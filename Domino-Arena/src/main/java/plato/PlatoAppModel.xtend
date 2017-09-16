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
import agregarPizza.IngredienteAdapterAbstract
import pizza.Distribucion

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
    Distribucion distribucion 		= new Distribucion

	
	new(Plato unPlato) {
		plato = unPlato
		pizzaSelect = plato.pizza
		sizeSelect = plato.tamanio
		setPrecio
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

	}

	def void setSizeSelect(Tamanio unTamanio) {
		sizeSelect = unTamanio


	}

	def void setPrecio() {
		if (!pizzaSelect.equals(null) && !sizeSelect.equals(null) && !plato.ingredientesExtras.equals(null)){
			var double costoTotal=pizzaSelect.precioBase * sizeSelect.factorDeTamanio + distribucion.costoDeIngredientes
			precio = costoTotal
			
		}
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
	
	
	
	

}













