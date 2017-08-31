import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashMap
import java.util.ArrayList

@Accessors
class Distribucion 
{
	HashMap<Ingrediente, DistribucionEnPizza> ingredientes
		
	new()
	{
		this.ingredientes = new HashMap<Ingrediente, DistribucionEnPizza>() 
	}
		
	def ingredientes()
	{
		this.getIngredientes
	}

	/**
	 * Agrega un nuevo ingrediente con su respectiva distribucion a la lista de ingredientes. 
	 * La distribucion puede ser "Todo", "Izquierda" o "Derecha". Si ya esta el ingrediente, lo reemplaza.
	 * @param nuevoIngrediente 	- El nuevo {@linkplain Ingrediente} a listar para la pizza
	 * @param unaDistribucion 	- La {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 * @Autor Victor Degano
	 */
	def void agregarIngrediente(Ingrediente nuevoIngrediente, DistribucionEnPizza unaDistribucion) 
	{
		this.ingredientes().put(nuevoIngrediente,unaDistribucion)
	}

	/**
	 * Quita el ingrediente de la lista de ingredientes. 
	 * Precondicion: El ingrediente tiene que estar 
	 * @param unIngrediente 	- El {@linkplain Ingrediente} a quitar
	 * @Autor Victor Degano
	 */
	def void quitarIngrediente(Ingrediente unIngrediente) 
	{
		if (this.ingredientes().containsKey(unIngrediente))
			this.ingredientes().remove(unIngrediente)
		else
			throw new RuntimeException("No Esta el ingrediente a sacar")
	}

	/**
	 * Modifica la distribucion de un ingrediente de la lista de ingredientes. 
	 * Si el ingrediente no esta en la lista, no hace nada
	 * @param unIngrediente 	- El {@linkplain Ingrediente} el cual se quiere cambiar la distribucion
	 * @param nuevaDistribucion	- El tipo de {@linkplain PosicionIngrediente} tipo de distribucion deseada "Toda" "Izquierda" o "Derecha"
	 * @Autor Victor Degano
	 */
	def void cambiarDistribucionDe(Ingrediente unIngrediente, DistribucionEnPizza nuevaDistribucion)
	{
		this.ingredientes().replace(unIngrediente,nuevaDistribucion)
		
	}
	
	def listaDeIngredientes() 
	{
		var listaDeIngredientes	= new ArrayList<Ingrediente>()
		listaDeIngredientes.addAll(this.ingredientes().keySet())
		listaDeIngredientes
	}
	
	def tieneIngredientes()
	{
		this.ingredientes().isEmpty()
	}
	
	def tieneAlIngrediente(Ingrediente unIngrediente) 
	{		
		this.ingredientes().containsKey(unIngrediente)
	}
	
	def posicionIngrediente(Ingrediente unIngrediente) 
	{
		this.ingredientes().get(unIngrediente)
	}
	
	def quitarIngredienteSInvalidos(ArrayList<Ingrediente> ingredientesInvalidos) 
	{
		ingredientesInvalidos.forEach[ ii | this.ingredientes().remove(ii)]
	}
	/* 
	def costoDeIngredientes()
	{
		this.ingredientes().keySet().stream().mapToInt([ i | i.precio()]).sum()	
	} */
	
	def costoDeIngredientes() {
		this.ingredientes().keySet().stream().mapToInt([ i | i.precio()]).sum()	
		//this.ingredientes().keySet().stream().mapToInt([ i | i.precio()]).sum()	
	}
	
}