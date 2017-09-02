package estados

import pedido.Pedido
import org.eclipse.xtend.lib.annotations.Accessors
import domino.PasajeACancelado

@Accessors
abstract class EstadoDePedido  {
	protected String nombre
	
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
		unPedido.notifyObservers(new PasajeACancelado)
	}
	
	def EstadoDePedido proximo()
	def EstadoDePedido previo()
}