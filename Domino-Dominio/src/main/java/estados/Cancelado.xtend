package estados

class Cancelado extends EstadoDePedido {
	
	override proximo() {
		this
	}
	
	override previo() {
		this
	}
}
