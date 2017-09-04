package pasajes

import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import domino.DominoPizza
import comunicables.ComunicadoParaViaje


// Responsabilidad: Encapsular el comportamiento de  los cambios que dominoPizza tiene que hacer 
//					sobre y con el pedido cuando su estado pasa a estar en viaje

@Accessors
class PasajeEnViaje implements Pasaje {
	
	// Estructura
	Comunicable comunicado
	
	// Constructor
	
	new(){
		comunicado = new ComunicadoParaViaje
	}
	
	// Metodos
	override ejecutar(Pedido unPedido, DominoPizza unDominoPizza) {
		unPedido.miembro.comunicar(comunicado)
	}
	
}