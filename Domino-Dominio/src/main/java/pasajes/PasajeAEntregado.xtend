package pasajes

import pedido.Pedido
import comunicables.ComunicadoParaEntregasTardias
import org.eclipse.xtend.lib.annotations.Accessors
import comunicables.Comunicable
import persistencia.Home

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
	override ejecutar(Pedido unPedido, Home unDominopizza) {
		if(unPedido.tardoMasDe30Minutos){
			unPedido.miembro.comunicar(comunicado)
		}
		unDominopizza.cerrarPedidoEntregadoCancelado(unPedido)
		
	}
	
}