package pasajes

import pedido.Pedido
import domino.DominoPizza
import comunicables.ComunicadoParaEntregasTardias
import org.eclipse.xtend.lib.annotations.Accessors
import comunicables.Comunicable

@Accessors
class PasajeAEntregado implements Pasaje {
	
    //Estructura
    Comunicable	comunicado
    
	new(){
		comunicado = new ComunicadoParaEntregasTardias
	}
	
	override ejecutar(Pedido unPedido, DominoPizza unDominopizza) {
		if(unPedido.tardoMasDe30Minutos){
			unPedido.miembro.comunicar(comunicado)
		}
		unDominopizza.cerrarPedidoEntregado(unPedido)
		
	}
	
}