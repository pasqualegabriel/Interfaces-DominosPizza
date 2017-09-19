package persistencia

import java.util.List
import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class HomeIngrediente {
	static HomeIngrediente instance
	
	static def getInstance(){
		if (instance == null)
		{ instance = new HomeIngrediente() }
		instance
	}
		
	// Estructura
	List<Ingrediente> ingredientesDisponibles = newArrayList
	

	
	/**
	 * Agrega un ingrediente a la lista de ingredientes. Si esta el ingrediente, no lo agrega
	 */
	def agregarIngrediente(Ingrediente unIngrediente) 
	{
		if (!ingredientesDisponibles.contains(unIngrediente)){ingredientesDisponibles.add(unIngrediente)}			
	}
	
	/**
	 * Quita un ingrediente de la lista de ingredientes. Si no esta el ingrediente, lanza una excepcion
	 * Precondicion: tiene que estar el ingrediente a quitar
	 */
	def borrarIngrediente(Ingrediente unIngrediente) 
	{
		if (ingredientesDisponibles.contains(unIngrediente)){ingredientesDisponibles.remove(unIngrediente)}	
		else
			throw new RuntimeException("No Esta el ingrediente a sacar")
	}
	
	
}