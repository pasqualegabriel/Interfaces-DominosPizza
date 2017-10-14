package pizza

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayListimport java.util.List
import org.uqbar.commons.model.annotations.TransactionalAndObservable

/**
 * Se encarga de organizar y contener a los ingredientes que se quieren en una pizza con su respectiva distribucion.
 */
@Accessors
@TransactionalAndObservable
class Distribucion 
{
	// Estructura
//	HashMap<Ingrediente, DistribucionEnPizza> ingredientes
	List<PairIngredienteDistribucionPizza> ingredientes
	
	// Constructores
	new()
	{
		ingredientes = newArrayList
	}

	
	// Metodos
	/**
	 * Agrega un nuevo ingrediente con su respectiva distribucion a la lista de ingredientes. 
	 * La distribucion puede ser "Todo", "Izquierda" o "Derecha". Si ya esta el ingrediente, lo reemplaza.
	 * @param nuevoIngrediente 	- El nuevo {@linkplain Ingrediente} a listar para la pizza
	 * @param unaDistribucion 	- La {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 */
	def void agregarIngrediente(Ingrediente nuevoIngrediente, DistribucionEnPizza unaDistribucion) 
	{
		var nuevoPar = new PairIngredienteDistribucionPizza(nuevoIngrediente,unaDistribucion)
		this.ingredientes.add(nuevoPar)
	}

	/**
	 * Quita el ingrediente de la lista de ingredientes. 
	 * Precondicion: El ingrediente tiene que estar 
	 * @param unIngrediente 	- El {@linkplain Ingrediente} a quitar
	 */
	def void quitarIngrediente(Ingrediente unIngrediente) 
	{
		if (this.tieneAlIngrediente(unIngrediente))
			this.ingredientes.remove(
										this.ingredientes.findFirst[ 
																	parID | 
																	parID.esElIngrediente(unIngrediente)
																   ]
									)
		else
			throw new RuntimeException("No Esta el ingrediente a sacar")
	}

	/**
	 * Modifica la distribucion de un ingrediente de la lista de ingredientes. 
	 * Si el ingrediente no esta en la lista, no hace nada
	 * @param unIngrediente 	- El {@linkplain Ingrediente} el cual se quiere cambiar la distribucion
	 * @param nuevaDistribucion	- El tipo de {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 */
	def void cambiarDistribucionDe(Ingrediente unIngrediente, DistribucionEnPizza nuevaDistribucion)
	{	this.ingredientes.findFirst[ parID | parID.esElIngrediente(unIngrediente)].cambiarDistribucion(nuevaDistribucion)	}

	/**
	 * Devuelve una ArrayList conteniendo a todos los ingredientes, esta lista no contiene la distribucion de los ingredientes. 
	 */	
	def listaDeIngredientes() 
	{
		val listaDeIngredientes	= new ArrayList<Ingrediente>()
		this.ingredientes.forEach[ parID | listaDeIngredientes.add(parID.ingrediente)]
		listaDeIngredientes
	}
	
	
	/**
	 * Devuelve un booleano en base a si tiene ingredientes o no. True en el caso que tenga al menos un ingrediente, False en caso contrario
	 */
	def tieneIngredientes()
	{
		this.ingredientes.isEmpty()
	}
	
	/**
	 * Devuelve un booleano en base a si esta ingrediente o no. True en el caso que lo tenga, False en caso contrario
	 * @param unIngrediente	- El {@linkplain Ingrediente} a querer saber si se encuentra.
	 */
	def tieneAlIngrediente(Ingrediente unIngrediente) 
	{		
		this.ingredientes.exists[parID | parID.esElIngrediente(unIngrediente)]
	}
	
	/**
	 * Da la posicion de un ingrediente guardado
	 * Precondicion: Tiene que estar el ingrediente a buscar.
	 *  @param unIngrediente	- El {@linkplain Ingrediente} del cual se quiere saber la {@linkplain DistribucionEnPizza}
	 */
	def posicionIngrediente(Ingrediente unIngrediente) 
	{
		this.ingredientes.findFirst[ parID | parID.esElIngrediente(unIngrediente)].distribucion
	}
	
	/**
	 * Quita los ingredientes que se se pasan de la lista. 
	 * Si algunos de esos ingredientes no se encuentra no hace nada y sigue con el siguiente ingrediente de la lista.
	 * @param ingredientesInvalidos	- La lista de ingredientes que se quieren quitar.
	 */
	def void quitarIngredienteSInvalidos(List<Ingrediente> ingredientesInvalidos) 
	{
		this.ingredientes.removeAll	(
									this.ingredientes	.filter[
																	parID | 
																	ingredientesInvalidos.contains(parID.ingrediente)
																]
														.toList
									)
	}
	
	/*
	 * Retorna la suma del costo de todos los ingredientes
	 */
	def costoDeIngredientes() 
	{	this.ingredientes.stream().mapToDouble([ parID | parID.ingrediente.precio]).sum()	}
	
	def quitarIngredienteConDistribucion(PairIngredienteDistribucionPizza unIngredienteConDistribucion) 
	{	this.ingredientes.remove(unIngredienteConDistribucion)	}
	
}
