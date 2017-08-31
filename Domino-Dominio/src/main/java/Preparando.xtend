

class Preparando extends EstadoDePedido{
	
	new(){
		super()
		nombre = "Preparando"
	}

	override siguiente(Pedido unPedido){
		var unaFormaDeEnvio = unPedido.formaDeRetiro
		var estadoSiguiente = unaFormaDeEnvio.avanzarEstado
		if(! estadoSiguiente.equals(null)){
			unPedido.estadoActual = estadoSiguiente
		} 
	}
	
	override previo() {
		this
	}
	
	override proximo() {
		
	}
}