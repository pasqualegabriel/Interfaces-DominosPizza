package pedido

import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Pizza

import pizza.Distribucion
import pizza.Ingrediente
import pizza.DistribucionEnPizza
import java.util.List
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Chica
import persistencia.HomePizza
import pizza.Tamanio

/**
 * Clase que modela a un plato del dominio de domino's pizza. 
 * Un plato se encarga de contener a la pizza elegida, tener un tamaño para la pizza, contener a los 
 * ingredientes extras que se le van a poner y calcular el costo total del plato.
 */
@Accessors
@TransactionalAndObservable
class Plato {
	// Atributos
	Pizza 			pizza
	Tamanio 		tamanio
	Distribucion 	ingredientesExtras

	new() {
		super()
		pizza 				= HomePizza.instance.promocionesDisponibles.get(0)
		tamanio 			= new Chica
		ingredientesExtras 	= new Distribucion
	}

	// Constructores
	new(Pizza unaPizza, Tamanio unTamanio, Distribucion unaDistribucion) {
		pizza 				= unaPizza
		tamanio				= unTamanio
		ingredientesExtras	= unaDistribucion
	}

	// Metodos
	/**
	 * Cambia la pizza del plato por la pizza pasada. Se quitaran de los ingredientes extras(Si los hubiere), 
	 * todo aquel ingrediente que este dentro de la pizza.
	 */
	def void cambiarPizza(Pizza unaPizza) {
		pizza = unaPizza
		quitarIngredientesExtrasInvalidos(this.pizza.listaDeIngredientes)
	}

	/**
	 * Toma una lista y quita todos los ingrediente extras del plato, si hay, que figuren en esa lista.
	 * @param ingredientesInvalidos	-	Es la lista de ingredientes que se quiere quitar de los ingredientes extras.
	 */
	def void quitarIngredientesExtrasInvalidos(List<Ingrediente> ingredientesInvalidos) {
		ingredientesExtras.quitarIngredienteSInvalidos(ingredientesInvalidos)
	}

	/**
	 * Agrega a la lista de ingredientes extras un nuevo ingrediente con su respectiva distribucion en la pizza.
	 * Si ya se encuentra el ingrediente en la lista, lo pisa con la nueva distribucion.
	 */
	def void agregarIngredienteExtra(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) {
		ingredientesExtras.agregarIngrediente(unIngrediente, unaDistribucion)
	}

	/**
	 * Quita al ingrediente de la lista de ingredientes extras.
	 * Si no se encuentra el ingrediente lanza un error.
	 */
	def void quitarIngredienteExtra(Ingrediente unIngrediente) {
		ingredientesExtras.quitarIngrediente(unIngrediente)
	}

	def void cambiarDistribucionDeUnIngrediente(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) {
		ingredientesExtras.cambiarDistribucionDe(unIngrediente, unaDistribucion)
	}

	/**
	 * Calcula el valor a pagar del plato. 
	 */
	def getPrecio() {
		precioDePizza * factorDeTamanio + costoDeIngredientesExtras
	}

	/**
	 * Devuelve el factor de tamaño para poder calcular el precio base de la pizza en base a este.
	 */
	private def factorDeTamanio() {
		tamanio.factorDeTamanio
	}

	/**
	 * Devuelve el precio base de la pizza.
	 */
	private def precioDePizza() {
		pizza.precioBase
	}

	/**
	 * Devuelve el precio total de todos los ingredientes extras seleccionados en el plato. 
	 */
	def costoDeIngredientesExtras() {
		ingredientesExtras.costoDeIngredientes
	}

}
