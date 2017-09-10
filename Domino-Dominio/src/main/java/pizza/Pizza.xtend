package pizza

import org.eclipse.xtend.lib.annotations.Accessorsimport org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

/**
 * Clase que modela la representacion de una pizza en Dominos.
 * La responsabilidad es la de mantener los ingredientes que la componene con su distribucion, el nombre y el precio que tendra.
 */
@Accessors
@Observable
@Transactional
class Pizza 
{
	// Atributos
	String 			nombre
	Integer 		precioBase
	Distribucion    distribucion
	
	// Constructor
	new(String unNombre, int unPrecio, Distribucion unaDistribucion) 
	{
		this.nombre 		= unNombre	
		this.precioBase 	= unPrecio
		this.distribucion 	= unaDistribucion
	}
	
	// Getters & Setters
	def void cambiarNombre(String unNombre) 
	{
		this.nombre = unNombre
	}
	
	def void cambiarPrecio(int nuevoPrecio) 
	{
		this.precioBase = nuevoPrecio
	}
	
	// Metodos
	/**
	 * Agrega un nuevo ingrediente con su respectiva distribucion a la lista de ingredientes de la pizza. 
	 * La distribucion puede ser "Todo", "Izquierda" o "Derecha". Si ya esta el ingrediente, lo reemplaza.
	 * @param nuevoIngrediente 	- El nuevo {@linkplain Ingrediente} a listar para la pizza
	 * @param unaDistribucion 	- La {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 */
	def void agregarIngrediente(Ingrediente nuevoIngrediente, DistribucionEnPizza unaDistribucion) 
	{
		this.distribucion.agregarIngrediente(nuevoIngrediente,unaDistribucion)
	}
	
	/**
	 * Quita el ingrediente de la lista de ingredientes de la pizza. 
	 * Precondicion: El ingrediente tiene que estar en la pizza 
	 * @param unIngrediente 	- El {@linkplain Ingrediente} a quitar de la pizza
	 */
	def void quitarIngrediente(Ingrediente unIngrediente) 
	{
		this.distribucion.quitarIngrediente(unIngrediente)
	}
	
	/**
	 * Modifica la distribucion de un ingrediente de la lista de ingredientes de la pizza. 
	 * Si el ingrediente no esta en la lista, no hace nada
	 * @param unIngrediente 	- El {@linkplain Ingrediente} el cual se quiere cambiar en la pizza
	 * @param nuevaDistribucion	- El {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 */
	def void cambiarDistribucionDe(Ingrediente unIngrediente, DistribucionEnPizza nuevaDistribucion)
	{
		this.distribucion.cambiarDistribucionDe(unIngrediente,nuevaDistribucion)
		
	}
	
	/**
	 * Devuelve la lista de ingredientes que contiene la pizza, esta lista no contiene la distribucion e los ingredientes.
	 */
	def listaDeIngredientes() 
	{
		this.distribucion.listaDeIngredientes()
	}
	
}
