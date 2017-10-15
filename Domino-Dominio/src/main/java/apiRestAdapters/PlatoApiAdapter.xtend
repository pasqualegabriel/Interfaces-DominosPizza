package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Plato
import pizza.Pizza
import pizza.Distribucion

@Accessors
class PlatoApiAdapter {
	
	// Atributos
	Pizza 			pizza
	String	 		tamanio
	Distribucion 	ingredientesExtras
	
	new() {	}
	
	new(Plato plato) {
		//Tamanio es una clase abstracta, por lo que para recrearse luego se le pide el nombre
		tamanio		 	   = plato.tamanio.nombre
		ingredientesExtras = plato.ingredientesExtras
		
		pizza 			   = plato.pizza
	
		
	}
	

	def convertir() {
		var unPlato = new Plato
				unPlato.tamanio 		   = (new TamanioApiAdapter).convertir(this.tamanio)
				unPlato.pizza  			   = this.pizza
				unPlato.ingredientesExtras = this.ingredientesExtras
		
		unPlato
	}
	
}