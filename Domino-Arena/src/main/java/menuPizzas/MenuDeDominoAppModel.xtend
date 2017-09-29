package menuPizzas

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza
import pizza.Ingrediente
import persistencia.HomePizza
import persistencia.HomeIngrediente
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.commons.model.utils.ObservableUtils

@Observable
@Accessors
class MenuDeDominoAppModel {
	Pizza pizzaSeleccionada
	Ingrediente ingredienteSeleccionado

	/**Agrega un ingrediente al repositorio de ingredientes y actualiza la lista de ingredientes disponibles */
	def agregarIngrediente(Ingrediente unIngrediente) {
		HomeIngrediente.instance.agregarIngrediente(unIngrediente)
		ObservableUtils.firePropertyChanged(this, "ingredientesDisponibles")

	}

	/**Elimina un ingrediente del repositorio de ingredientes y actualiza la lista de ingredientes disponibles */
	def eliminarIngrediente() {
		if (this.getIngredientesDisponibles.size > 1) {
			HomeIngrediente.instance.borrarIngrediente(ingredienteSeleccionado)
			ingredienteSeleccionado = null
			ObservableUtils.firePropertyChanged(this, "ingredientesDisponibles")

		} else {
			throw new UserException("No se puede eliminar el ultimo ingrediente")
		}

	}

	/**Agrega una pizza al repositorio de pizzas y actualiza la lista de promociones disponibles*/
	def agregarPromocion(Pizza unaPizza) {
		HomePizza.instance.agregarPromocion(unaPizza)
		ObservableUtils.firePropertyChanged(this, "promosDisponibles")

	}

	/**Elimina una pizza del repositorio de pizzas y actualiza la lista de promociones disponibles*/
	def eliminarPizza() {
		if (this.getPromosDisponibles.size > 1) {
			HomePizza.instance.borrarPromocion(pizzaSeleccionada)
			pizzaSeleccionada = null
			ObservableUtils.firePropertyChanged(this, "promosDisponibles")
		} else {
			throw new UserException("No se puede eliminar la ultima promocion")
		}

	}

	def getPromosDisponibles() {
		HomePizza.instance.todasLasPromociones // CORREGIDO //faltan los firepropertychanged
	}

	def getIngredientesDisponibles() {
		HomeIngrediente.instance.todosLosIngredientes // CORREGIDO //faltan los firepropertychanged
	}

}
