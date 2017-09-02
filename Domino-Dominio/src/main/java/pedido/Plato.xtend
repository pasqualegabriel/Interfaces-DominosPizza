package pedido

import org.eclipse.xtend.lib.annotations.Accessorsimport pizza.Pizza
import pizza.Tamanio
import pizza.Distribucion
import pizza.Ingrediente
import pizza.DistribucionEnPizza
import java.util.List

/**
 * Clase que modela a un plato del dominio de domino's pizza. 
 * Un plato se encarga de contener a la pizza elegida, tener un tamaño para la pizza, contener a los 
 * ingredientes extras que se le van a poner y calcular el costo total del plato.
 */
@Accessors
class Plato 
{
	//Atributos
	Pizza pizza
	Tamanio tamanio
	Distribucion ingredientesExtras
	
	//Constructores
	new(Pizza unaPizza, Tamanio unTamanio, Distribucion unaDistribucion)
	{
		this.pizza = unaPizza
		this.tamanio = unTamanio
		this.ingredientesExtras = unaDistribucion	
	}
	
	//Getters & Setters	
	
	//Metodos
	/**
	 * Cambia la pizza del plato por la pizza pasada. Se quitaran de los ingredientes extras(Si los hubiere), 
	 * todo aquel ingrediente que este dentro de la pizza.
	 * @param unaPizza	- La {@linkplain Pizza} que se va a poenr en el plato 
	 */
	def void cambiarPizza(Pizza unaPizza) 
	{
		this.pizza = unaPizza
		this.quitarIngredientesExtrasInvalidos(this.pizza.listaDeIngredientes())
	}
	
	/**
	 * Toma una lista y quita todos los ingrediente extras del plato, si hay, que figuren en esa lista.
	 * @param ingredientesInvalidos	-	Es la lista de ingredientes que se quiere quitar de los ingredientes extras.
	 */
	private def void quitarIngredientesExtrasInvalidos(List<Ingrediente> ingredientesInvalidos) 
	{
		this.ingredientesExtras.quitarIngredienteSInvalidos(ingredientesInvalidos)
	}

	/**
	 * Agrega a la lista de ingredientes extras un nuevo ingrediente con su respectiva distribucion en la pizza.
	 * Si ya se encuentra el ingrediente en la lista, lo pisa con la nueva distribucion.
	 * @param unIngrediente		- El {@linkplain Ingrediente} que se quiere agregar a la lista
	 * @param unaDistribucion	- La {@linkplain Distribucion} correspondiente al ingrediente
	 */
	def void agregarIngredienteExtra(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) 
	{
		this.ingredientesExtras.agregarIngrediente(unIngrediente, unaDistribucion)
	}

	/**
	 * Quita al ingrediente de la lista de ingredientes extras.
	 * Si no se encuentra el ingrediente lanza un error.
	 * @param unIngrediente		- El {@linkplain Ingrediente} que se quiere quitar de la lista
	 */
	def void quitarIngredienteExtra(Ingrediente unIngrediente) 
	{
		this.ingredientesExtras.quitarIngrediente(unIngrediente)
	}

	/**
	 * Calcula el valor a pagar del plato. 
	 */
	def calcularPrecio() 
	{
		(this.precioDePizza() * factorDeTamanio() + costoDeIngredientesExtras()).intValue()
		
	}
	
	/**
	 * Devuelve el factor de tamaño para poder calcular el precio base de la pizza en base a este.
	 */
	private def factorDeTamanio() {
		this.tamanio.factorDeTamanio()
	}
	
	/**
	 * Devuelve el precio base de la pizza.
	 */
	private def precioDePizza() {
		this.pizza.precioBase
	}
	
	/**
	 * Devuelve el precio total de todos los ingredientes extras seleccionados en el plato. 
	 */
	def costoDeIngredientesExtras() 
	{
		this.ingredientesExtras.costoDeIngredientes
	}
	
}
