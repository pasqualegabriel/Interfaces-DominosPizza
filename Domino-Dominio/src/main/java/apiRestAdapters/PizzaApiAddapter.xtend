package apiRestAdapters

import pizza.Pizza
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List


@Accessors
class PizzaApiAddapter {
	String 										nombre
	Double	   									precio
	List<PairIndredienteDistribucion> 			ingredientes = newArrayList
	
	new(){}
	
	new(Pizza aPizza){
		nombre			= aPizza.nombre
		precio			= aPizza.precioBase
		aPizza.distribucion.ingredientes.forEach[ 
			n| ingredientes.add(new PairIndredienteDistribucion(n.ingrediente,n.distribucion.toString))
		]
	}
}
