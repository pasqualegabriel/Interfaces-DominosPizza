package pedido

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessorsimport pizza.Pizza
import pizza.Tamanio
import pizza.Distribucion
import pizza.Ingrediente
import pizza.DistribucionEnPizza

@Accessors
class Plato 
{
	Pizza pizza
	Tamanio tamanio
	Distribucion ingredientesExtras
	
	new(Pizza unaPizza, Tamanio unTamanio, Distribucion unaDistribucion)
	{
		this.pizza = unaPizza
		this.tamanio = unTamanio
		this.ingredientesExtras = unaDistribucion	
	}
	
	def pizza()
	{
		this.getPizza
	}
	
	def tamanio()
	{
		this.getTamanio
	}
	
	def ingredientesExtras()
	{
		this.getIngredientesExtras
	}
	
	def void cambiarPizza(Pizza unaPizza) 
	{
		this.pizza = unaPizza
		this.quitarIngredientesExtrasInvalidos(this.pizza().listaDeIngredientes())
	}
	
	def void quitarIngredientesExtrasInvalidos(ArrayList<Ingrediente> ingredientesInvalidos) 
	{
		this.ingredientesExtras().quitarIngredienteSInvalidos(ingredientesInvalidos)
	}

	/**
	 * Agrega a la lista de ingredientes extras un nuevo ingrediente con su respectiva distribucion en la pizza.
	 * Si ya se encuentra el ingrediente en la lista, lo pisa con la nueva distribucion.
	 * @param unIngrediente		- El {@linkplain Ingrediente} que se quiere agregar a la lista
	 * @param unaDistribucion	- La {@linkplain Distribucion} correspondiente al ingrediente
	 */
	def void agregarIngredienteExtra(Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion) 
	{
		this.ingredientesExtras().agregarIngrediente(unIngrediente, unaDistribucion)
	}

	/**
	 * Quita al ingrediente de la lista de ingredientes extras.
	 * Si no se encuentra el ingrediente lanza un error.
	 * @param unIngrediente		- El {@linkplain Ingrediente} que se quiere quitar de la lista
	 */
	def void quitarIngredienteExtra(Ingrediente unIngrediente) 
	{
		this.ingredientesExtras().quitarIngrediente(unIngrediente)
	}

	/**
	 * Calcula el valor a pagar del plato. 
	 */
	def calcularPrecio() 
	{
		(this.precioDePizza() * factorDeTamanio() + costoDeIngredientesExtras()).intValue()
		
	}
	
	private def factorDeTamanio() {
		this.tamanio().factorDeTamanio()
	}
	
	private def precioDePizza() {
		this.pizza().precioBase()
	}
	
	def costoDeIngredientesExtras() 
	{
		this.ingredientesExtras.costoDeIngredientes
	}
	
}
