package domino

import pedido.Pedido

class PasajeACancelado implements EstrategiaDeNotificacion
{
	
	override enviar(DominoPizza unDominoPizza, Pedido unPedido) 
	{ }
	
	override tituloMensaje() 
	{ "" }
	
	override cuerpoMensaje() 
	{ "" }
	
}