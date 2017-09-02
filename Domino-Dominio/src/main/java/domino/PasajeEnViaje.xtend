package domino

import pedido.Pedido
import mailSender.GMailSender

class PasajeEnViaje implements EstrategiaDeNotificacion 
{
	/**
	 * Envia al cliente un mail informandole que su pedido ya esta en camino
	 */
	override enviar(DominoPizza unDominoPizza, Pedido unPedido) 
	{
		
		GMailSender.instance.sendMail(unPedido.miembro.mail,this.tituloMensaje,this.cuerpoMensaje())
	}
	
	/**
	 * Retorna un titulo para el mail
	 */
	override tituloMensaje() 
	{
		"Pedido en Viaje!"
	}
	
	/**
	 * Retorna un cuerpo para el mail
	 */
	override cuerpoMensaje() 
	{
		"Su Pedido de ya esta en camino!"
	}
	
}