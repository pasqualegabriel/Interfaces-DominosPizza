package plato

import pedido.Plato
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Pizza
import java.util.List
import pizza.Distribucion
import pizza.Porcion
import pizza.Chica
import pizza.Grande
import pizza.Familiar
import persistencia.HomePizza
import edicionDePromocion.IngredienteAdapterAbstract
import org.uqbar.commons.model.utils.ObservableUtils

@Accessors
@TransactionalAndObservable
class PlatoAppModel {
	double precio

	Plato plato

	List<Pizza> pizzaItems = newArrayList
	Pizza pizzaSelect
	Tamanio sizeSelect

	List<IngredienteAdapterAbstract> ingredientesExtras = newArrayList

	new(Plato unPlato) {
		coleccionPizzaItems
		plato = unPlato
		asignarPizza
		pizzaSelect = plato.pizza
		sizeSelect = itemsSize.findFirst[t|t.nombre.equals(unPlato.tamanio.nombre)]
		precio = 0
	}

	def List<Tamanio> getItemsSize() {
		#[new Porcion, new Chica, new Grande, new Familiar]
	}

	/**Asigna una pizza solamente cuando  el objeto adaptado<Plato> no tiene una pizza*/
	def void asignarPizza() {
		if (plato.pizza == null) {
			plato.pizza = HomePizza.instance.promocionesDisponibles.get(0)
		}
	}

	def void setPizzaSelect(Pizza unaPizza) { pizzaSelect = unaPizza }

	def void setSizeSelect(Tamanio unTamanio) { sizeSelect = unTamanio }

	/**Devuelve el precio total de los ingredientes extras elegidos */
	def getPrecioDeIngredientesExtras() {
		ingredientesExtras.stream.mapToDouble[it.getPrecio].sum()
	}

	/**Calcula el precio del plato para poder mostrarlo */
	def calcularPrecio() { precio = (pizzaSelect.precioBase * sizeSelect.factorDeTamanio) + precioDeIngredientesExtras }

	/**Protocolo */
	/**Carga todas las promoociones disponibles a la lista de pizzaItems*/
	def coleccionPizzaItems() { pizzaItems.addAll(HomePizza.instance.promocionesDisponibles) }

	/**Agrega todos los ingredientes extras de la lista ingredientesExtras, a la lista de ingredientes extras del plato*/
	def agregarIngredientes() {
		plato.ingredientesExtras = new Distribucion
		ingredientesExtras.forEach[it.agregarse]
	}

	/**Agrega todos los ingredientes elegidos con su distribucion al plato*/
	def void aceptarCambio() {
		agregarIngredientes
		plato.pizza = pizzaSelect
		plato.tamanio = sizeSelect
		ObservableUtils.firePropertyChanged(this, "calcularPrecio")
	}

}
