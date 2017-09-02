package pasajes

import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import domino.DominoPizza
import comunicables.ComunicadoParaViaje

@Accessors
class PasajeEnViaje implements Pasaje {
	
	// Estructura
	Comunicable comunicado
	
	// Constructor
	
	new(){
		comunicado = new ComunicadoParaViaje
	}
	
	override ejecutar(Pedido unPedido, DominoPizza unDominoPizza) {
		unPedido.miembro.comunicar(comunicado)
	}
	
}