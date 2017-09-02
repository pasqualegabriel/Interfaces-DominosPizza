package pasajes

import comunicables.ComunicacionEnViaje
import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import domino.DominoPizza

@Accessors
class PasajeEnViaje {
	
	// Estructura
	Comunicable comunicacion
	
	// Constructor
	
	new(){
		comunicacion = new ComunicacionEnViaje
	}
	
	def ejecutar(Pedido pedido, DominoPizza pizza) {
		pedido.miembro.comunicar(comunicacion)
	}
	
}