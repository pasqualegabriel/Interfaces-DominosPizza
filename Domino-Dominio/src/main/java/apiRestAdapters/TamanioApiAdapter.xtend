package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pizza.Tamanio
import pizza.Porcion
import pizza.Grande
import pizza.Familiar
import pizza.Chica

@Accessors
class TamanioApiAdapter {
	List<Tamanio> tamanios = newArrayList
	
	new() {
		tamanios.add(new Chica)
		tamanios.add(new Familiar)
		tamanios.add(new Grande);
		tamanios.add(new Porcion)
	}
	
	def convertir(String unNombre) {
		tamanios.findFirst[it.nombre.equals(unNombre)] 	
	}
}