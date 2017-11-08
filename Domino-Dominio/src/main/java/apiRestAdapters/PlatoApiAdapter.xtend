package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Plato
import pizza.Distribucion

@Accessors
class PlatoApiAdapter {
	
	// Atributos
	PizzaApiAddapter 			pizza
	TamanioApiAdapter	 		tamanio
	Distribucion 				ingredientesExtras

	
	new() {	}
	
	new(Plato plato) {
		//Tamanio es una clase abstracta, por lo que para recrearse luego se le pide el nombre
		tamanio		 	   = new TamanioApiAdapter(plato.tamanio)
		ingredientesExtras = plato.ingredientesExtras
		
		pizza 			   =  new PizzaApiAddapter(plato.pizza)
	
		
	}
	

	def convertir() {
		var unPlato = new Plato
				unPlato.tamanio 		   = this.tamanio.convertir
				unPlato.pizza  			   = this.pizza.convertir
				unPlato.ingredientesExtras = this.ingredientesExtras
		
		unPlato
	}
	
}