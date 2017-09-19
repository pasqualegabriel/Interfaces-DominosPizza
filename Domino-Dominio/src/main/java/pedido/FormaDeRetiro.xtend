package pedido

import estados.EstadoDePedido

// Responsabilidad: -Manejar comportamiento de pedido el cual depende de la forma en la cual el usuario 
//                  quiere que su pedido se retire

interface FormaDeRetiro 
{

	def EstadoDePedido avanzarEstado()

	def Double precioDeRetiro()
}