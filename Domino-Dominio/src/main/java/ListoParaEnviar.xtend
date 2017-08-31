
class ListoParaEnviar extends EstadoDePedido{
	

	
	override previo() {
		var estadoPrevio = new Preparando
		estadoPrevio
	}
	
	override proximo() {
		var estadoProximo = new EnViaje
		estadoProximo
	}
	
}