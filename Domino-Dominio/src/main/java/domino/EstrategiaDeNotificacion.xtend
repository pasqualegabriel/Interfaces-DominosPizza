package domino

import pedido.Pedido
import persistencia.Home

/**
 * Interfaz encargada de que se realice la notificacion al cliente segun el estado de un pedido y el manejo del pedido en dominopizza.
 * Responsabilidad: Realizar la comunicacion al cliente del estado del pedido y si fuese necesario realizar el manejo del pedido en domino.
 */

interface EstrategiaDeNotificacion 
{
	def void enviar(Home unDominoPizza, Pedido unPedido)	
	
	def String tituloMensaje()
	
	def String cuerpoMensaje()
}
