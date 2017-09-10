package pasajes

import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import comunicables.ComunicadoParaViaje
import persistencia.Home

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
	override ejecutar(Pedido unPedido, Home unDominoPizza) {
		unPedido.miembro.comunicar(comunicado)
	}
	
}