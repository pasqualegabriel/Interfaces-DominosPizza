package domino

import comunicables.Comunicable
import formasDeComunicacion.FormaDeComunicacion
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido

// Responsabilidad: Representacion informatica de los usuarios del servicio junto con sus preferencias

@Accessors
abstract class Usuario {
	// Estructura
	String 				nombre
	String 				nick
	FormaDeComunicacion formaDeComunicacion
	
	// Metodo
	
	abstract def void comunicar(Comunicable unaComunicacion)
	
	abstract def void agregarPedido(Pedido pedido)
	

}