package apiRestAdapters

import pizza.Pizza
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class PizzaApiAddapter {
	String 										nombre
	Double	   									precioBase
	DistribudorAdapterApi 						distribucion 
	
	new(){}
	
	new(Pizza aPizza){
		nombre				= aPizza.nombre
		precioBase			= aPizza.precioBase
		distribucion 		= new DistribudorAdapterApi(aPizza.distribucion)

	}
	
	def convertir() {

		return new Pizza(nombre,precioBase,distribucion.convertir)
	}
	
}
