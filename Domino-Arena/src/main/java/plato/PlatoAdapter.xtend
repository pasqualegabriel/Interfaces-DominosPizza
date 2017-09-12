package plato

import pedido.Plato
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Pizza
import java.util.List
import persistencia.Home

@Accessors
@TransactionalAndObservable
class PlatoAdapter {
	 
	
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
		setPrecio
	}

	def void setSizeSelect(Tamanio unTamanio) {
		sizeSelect = unTamanio
		setPrecio

	}

	def void setPrecio() {
		if (!pizzaSelect.equals(null) && !sizeSelect.equals(null)){
			precio = "$" + pizzaSelect.precioBase * sizeSelect.factorDeTamanio
		}
	}

}
