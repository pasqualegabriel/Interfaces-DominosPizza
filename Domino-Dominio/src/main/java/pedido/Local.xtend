package pedido

import estados.ListoParaRetirar

class Local implements  FormaDeRetiro {
	
	override avanzarEstado() {
		var estado = new ListoParaRetirar
		estado
	}	
}