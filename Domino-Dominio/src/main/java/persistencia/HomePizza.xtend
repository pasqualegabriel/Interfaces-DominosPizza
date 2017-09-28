package persistencia

import pizza.Pizza
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class HomePizza {
	static HomePizza instance

	static def getInstance() {
		if (instance == null) {
			instance = new HomePizza()
		}
		instance
	}
	// Estructura
	List<Pizza>		  promocionesDisponibles  = newArrayList
	
	def getPromocionesDisponibles(){
		this.promocionesDisponibles
	}
	
	/**
	 * Agrega una pizza a la lista de promociones. Si esta la pizza, no la agrega
	*/	
	def agregarPromocion(Pizza unaPizza) 
	{
		if (!promocionesDisponibles.contains(unaPizza)){promocionesDisponibles.add(unaPizza)} 
				
	}
	
	/**
	 * Quita una pizza de la lista de Promociones. Si no esta la Pizza, lanza una excepcion
	 * Precondicion: tiene que estar la pizza a quitar
	 */
	def borrarPromocion(Pizza unaPizza) 
	{
		
		//if(promocionesDisponibles.contains(unaPizza)){promocionesDisponibles.remove(unaPizza)}
		promocionesDisponibles.remove(unaPizza)
	}
	
	def getTodasLasPromociones() {
		val listaDePromociones = newArrayList
		promocionesDisponibles.forEach[listaDePromociones.add(it)]
		listaDePromociones
	}
	
}
