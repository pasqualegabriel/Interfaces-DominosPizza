package pedido

import estados.ListoParaRetirar
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de que quiera retirar su pedido por el local
@Accessors
class Local  extends FormaDeRetiro{ 
	
	
	new() 
	{	this.tipo = "Local"	}
	
	// Metodos
	override avanzarEstado() {
		new ListoParaRetirar
	}
	
	override precioDeRetiro() 
	{
		0.00
	}
	
}