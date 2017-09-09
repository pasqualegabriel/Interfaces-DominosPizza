package estados

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: -Manejar comportamiento de pedido el cual depende del estado en el cual se encuentre
//                  -Indicar cual es el siguiente o anterior estado que le sigue

@Accessors
abstract class EstadoDePedido  {
	
	// Estructura
	protected String nombre
	
	// Metodos
	 def void siguiente(Pedido unPedido){
		var estadoSiguiente = this.proximo()
		unPedido.estadoActual = estadoSiguiente
	}
	
	def void anterior(Pedido unPedido){
		var estadoAnterior = this.previo()
		
		unPedido.estadoActual = estadoAnterior
			  
	}

	def void cancelar(Pedido unPedido)
	{
		unPedido.estadoActual= new Cancelado()

	}
	
	def EstadoDePedido proximo()
	def EstadoDePedido previo()
	

	
}