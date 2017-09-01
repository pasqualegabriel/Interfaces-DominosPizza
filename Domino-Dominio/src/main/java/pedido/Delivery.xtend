package pedido

import estados.ListoParaEnviar

class Delivery implements FormaDeRetiro{
	
	override avanzarEstado() {
		var estadoADevolver = new ListoParaEnviar
		estadoADevolver
	}

	
}
