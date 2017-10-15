package pedido

import estados.EstadoDePedido
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de la forma en la cual el usuario 
//                  quiere que su pedido se retire
@Accessors
abstract class FormaDeRetiro 
{
	String tipo
	
	def EstadoDePedido avanzarEstado()

	def Double precioDeRetiro()
}