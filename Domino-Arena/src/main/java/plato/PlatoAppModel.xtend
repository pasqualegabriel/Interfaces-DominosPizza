package plato

import pedido.Plato
import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Pizza
import java.util.List
import pizza.Ingrediente
import pizza.DistribucionEnPizza
import pizza.Distribucion
import agregarPizza.IngredienteAdapterAbstract
import pizza.Porcion
import pizza.Chica
import pizza.Grande
import pizza.Familiar
import persistencia.HomePizza


@Accessors
@TransactionalAndObservable
class PlatoAppModel 
{	
	double precio
		
	Plato plato
	
	List<Pizza> pizzaItems			= newArrayList
	Pizza pizzaSelect
	
	List<Tamanio> itemsSize 		= #[new Porcion, new Chica, new Grande, new Familiar]
	Tamanio sizeSelect
	
	List<IngredienteAdapterAbstract> ingredientesExtras = newArrayList
    
	
	new(Plato unPlato) 
	{
		coleccionPizzaItems
		plato 			= unPlato
		asignarPizza
		pizzaSelect		= plato.pizza
		sizeSelect		= itemsSize.findFirst[ t | t.nombre.equals(unPlato.tamanio.nombre) ]
		precio 			= 0
	}
	
	/**Asigna una pizza solamente cuando  el objeto adaptado<Plato> no tiene una pizza*/
	def asignarPizza() 
	{
		if(plato.pizza==null)
		{	plato.pizza 	= HomePizza.instance.promocionesDisponibles.get(0)	}
	}


	/**Carga todas las promoociones disponibles a la lista de pizzaItems*/
	def coleccionPizzaItems() 
	{	pizzaItems.addAll(HomePizza.instance.promocionesDisponibles)	}

	def void setPizzaSelect(Pizza unaPizza) 
	{	pizzaSelect = unaPizza	}

	def void setSizeSelect(Tamanio unTamanio) 
	{	sizeSelect = unTamanio	}
	
	/**Agrega al ingrediente con uan distribucion en pizza a la lista de ingredientes extras del plato */
	def agregaIngredienteExtra(Ingrediente ingrediente, DistribucionEnPizza distribucion) 
	{	plato.agregarIngredienteExtra(ingrediente,distribucion)	}
	
	/**Cambia la distribucion en pizza del ingrediente de la lista de ingredientes extras del plato*/
	def cambiarDistribucionDeIngredienteExtra(Ingrediente unIngrediente,DistribucionEnPizza unaDistribucion) 
	{	plato.cambiarDistribucionDeUnIngrediente(unIngrediente,unaDistribucion)	}
	
	/**Agrega todos los ingredientes extras de la lista ingredientesExtras, a la lista de ingredientes extras del plato*/
	def agregarIngredientes() 
	{
		plato.ingredientesExtras= new Distribucion
		for (IngredienteAdapterAbstract ingrediente: ingredientesExtras)
		{	ingrediente.agregarse	}
	}
	
	/**Calcula el precio del plato para poder mostrarlo */
	def calcularPrecio() 
	{	precio = (pizzaSelect.precioBase * sizeSelect.factorDeTamanio) + precioDeIngredientesExtras	}
	
	/**Devuelve el precio total de los ingredientes extras elegidos */
	def getPrecioDeIngredientesExtras() 
	{
		var double precioDeIngredientesExtras = 0.00
		for(IngredienteAdapterAbstract i: ingredientesExtras)
		{	precioDeIngredientesExtras += i.getPrecio	}
		precioDeIngredientesExtras
	}
	
	/**Agrega todos los ingredientes elegidos con su distribucion al plato*/
	def void aceptarCambio()
	{	
		agregarIngredientes
		plato.pizza = pizzaSelect
		plato.tamanio = sizeSelect
	}

}













