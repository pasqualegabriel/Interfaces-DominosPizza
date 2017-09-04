package pasajes

import pedido.Pedido
import domino.DominoPizza
import comunicables.ComunicadoParaEntregasTardias
import org.eclipse.xtend.lib.annotations.Accessors
import comunicables.Comunicable

// Responsabilidad: Encapsular el comportamiento de  los cambios que dominoPizza tiene que hacer 
//					sobre y con el pedido cuando su estado pasa a estar entregado

@Accessors
class PasajeAEntregado implements Pasaje {
	
    // Estructura
    Comunicable	comunicado
    
    // Constructor
	new(){
		comunicado = new ComunicadoParaEntregasTardias
	}
	
	// Metodos
	override ejecutar(Pedido unPedido, DominoPizza unDominopizza) {
		if(unPedido.tardoMasDe30Minutos){
			unPedido.miembro.comunicar(comunicado)
		}
		unDominopizza.cerrarPedidoEntregado(unPedido)
		
	}
	
}