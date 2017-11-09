package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pizza.Tamanio
import pizza.Porcion
import pizza.Grande
import pizza.Familiar
import pizza.Chica

@Accessors
class TamanioApiAdapter {
	
	String nombre
	double factorDeTamanio
	
	
	new(){
		super()
	}

	new(Tamanio tamanio) {
		nombre= tamanio.nombre
		factorDeTamanio= tamanio.factorDeTamanio
	}
	
	def convertir() {
		tamanios.findFirst[it.nombre.equalsIgnoreCase(nombre)] 	
	}
	
	def tamanios(){
		# [new Chica, new Familiar, new Grande, new Porcion]
	}
}