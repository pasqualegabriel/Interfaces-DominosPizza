package domino

import pedido.Pedido
import mailSender.GMailSender

class PasajeAEntregado implements EstrategiaDeNotificacion
{
	
	/**
	 * Envia al cliente un mail informandole que su pedido ya esta en camino
	 */
	override enviar(DominoPizza unDominoPizza, Pedido unPedido) 
	{
		unDominoPizza.cerrarPedidoEntregado(unPedido)
		
		if (unPedido.tardoMasDe30Minutos)
		{
			GMailSender.instance.sendMail(unPedido.miembro.mail, this.tituloMensaje, this.cuerpoMensaje())
		}
	}
	
	/**
	 * Retorna un titulo para el mail
	 */
	override tituloMensaje() 
	{
		"Disculpas! Su Pedido aun no ha sido entregado"
	}

	/**
	 * Retorna un cuerpo para el mail
	 */	
	override cuerpoMensaje() 
	{
		"Sentimos mucho la demora en la entrega en su pedido. En breve lo estara recibiendo, sepa disculpar la demora"
	}
	
}