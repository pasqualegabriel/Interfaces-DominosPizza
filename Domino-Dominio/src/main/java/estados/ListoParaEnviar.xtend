package estados

import pedido.Pedido
import comunicables.ComunicadoParaViaje

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que este este listo para enviar
//                  -Indicar cual es el siguiente o anterior estado que le sigue

class ListoParaEnviar extends EstadoDePedido
{
	// Metodos
	override void siguiente(Pedido unPedido)
	{
		super.siguiente(unPedido)
		unPedido.miembro.comunicar(new ComunicadoParaViaje)
	}
	
	override previo() {
		var estadoPrevio = new Preparando
		estadoPrevio
	}
	
	override proximo() {
		var estadoProximo = new EnViaje
		estadoProximo
	}
	
	override nombre() {
		"Listo para enviar"
	}
	
}