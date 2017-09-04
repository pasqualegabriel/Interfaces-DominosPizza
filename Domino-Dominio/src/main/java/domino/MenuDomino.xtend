package domino

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessorsimport pizza.Ingrediente
import pizza.Pizza

// Responsabilidad: Administrar las promociones e ingredientes disponibles

@Accessors
class MenuDomino 
{
	// Estructura
	ArrayList<Ingrediente> ingredientesDisponibles
	ArrayList<Pizza>	   promocionesDisponibles

	// Constructores
	new()
	{
		ingredientesDisponibles	= new ArrayList<Ingrediente>()
		promocionesDisponibles	= new ArrayList<Pizza>()
	}
	
	// Metodos
	def ingredientesDisponibles()
	{
		this.getIngredientesDisponibles
	}
	
	def promocionesDisponibles()
	{
		this.getPromocionesDisponibles
	}

	/**
	 * Agrega una pizza a la lista de promociones. Si esta la pizza, no la agrega
	 */	
	def agregarPromocion(Pizza unaPizza) 
	{
		if (!this.promocionesDisponibles().contains(unaPizza)) 
			this.promocionesDisponibles().add(unaPizza)
	}
	
	/**
	 * Quita una pizza de la lista de Promociones. Si no esta la Pizza, lanza una excepcion
	 * Precondicion: tiene que estar la pizza a quitar
	 */
	def borrarPromocion(Pizza unaPizza) 
	{
		if (this.promocionesDisponibles().contains(unaPizza))
			this.promocionesDisponibles().remove(unaPizza)
		else
			throw new RuntimeException("No Esta La Pizza Promocion a sacar a sacar")
	}
	
	/**
	 * Agrega un ingrediente a la lista de ingredientes. Si esta el ingrediente, no lo agrega
	 */
	def agregarIngrediente(Ingrediente unIngrediente) 
	{
		if (!this.ingredientesDisponibles().contains(unIngrediente))
			this.ingredientesDisponibles().add(unIngrediente)
	}
	
	/**
	 * Quita un ingrediente de la lista de ingredientes. Si no esta el ingrediente, lanza una excepcion
	 * Precondicion: tiene que estar el ingrediente a quitar
	 */
	def borrarIngrediente(Ingrediente unIngrediente) 
	{
		if (this.ingredientesDisponibles().contains(unIngrediente))
			this.ingredientesDisponibles().remove(unIngrediente)
		else
			throw new RuntimeException("No Esta el ingrediente a sacar")
	}		
}
