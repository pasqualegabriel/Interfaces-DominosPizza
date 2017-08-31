
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
	
	def EstadoDePedido proximo()
	def EstadoDePedido previo()
}