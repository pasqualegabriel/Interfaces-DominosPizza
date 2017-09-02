package pedido

import estados.EstadoDePedido

interface FormaDeRetiro 
{

	def EstadoDePedido avanzarEstado()

	def Integer precioDeRetiro()
}