package domino

import formasDeComunicacion.FormaDeComunicacion
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import comunicables.Comunicable

// Responsabilidad: Representacion informatica de los usuarios del servicio junto con sus preferencias

@Accessors
abstract class Usuario {
	// Estructura
	String 				nombre
	String 				nick
	FormaDeComunicacion formaDeComunicacion
	
	// Metodo
	def abstract void agregarPedido(Pedido unPedido);
	
	def abstract void comunicar(Comunicable unComunicable);
	
	def  boolean esInvitado(){
		true
	}

}