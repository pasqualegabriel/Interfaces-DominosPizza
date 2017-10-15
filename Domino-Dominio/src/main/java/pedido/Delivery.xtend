package pedido

import estados.ListoParaEnviar
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que quiera retirar su pedido por delivery
@Accessors
class Delivery extends FormaDeRetiro{
	
	String direccion
	
	new(String unaDireccion) 
	{	
		this.tipo 		= "Delivery"
		this.direccion	= unaDireccion
	}
	
	// Metodos 
	override avanzarEstado() {
		new ListoParaEnviar
	}
	
	override precioDeRetiro() 
	{
		15.00
	}

	
}
