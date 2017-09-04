package pedido

import estados.ListoParaRetirar

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que quiera retirar su pedido por el local

class Local implements  FormaDeRetiro {
	
	// Metodos
	override avanzarEstado() {
		var estado = new ListoParaRetirar
		estado
	}
	
	override precioDeRetiro() 
	{
		0
	}
	
}