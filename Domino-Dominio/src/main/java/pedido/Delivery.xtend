package pedido

import estados.ListoParaEnviar

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que quiera retirar su pedido por delivery

class Delivery implements FormaDeRetiro{
	
	// Metodos 
	override avanzarEstado() {
		var estadoADevolver = new ListoParaEnviar
		estadoADevolver
	}
	
	override precioDeRetiro() 
	{
		15
	}

	
}
