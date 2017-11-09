package domino

import org.eclipse.xtend.lib.annotations.Accessors
import pedido.Pedido
import comunicables.Comunicable

// Responsabilidad: Representar a un usuario cliente
@Accessors
class Invitado extends Usuario {

	new () {
		this.nombre	= "Invitado"
		this.nick	= "Invitado"
	}
	
	override void agregarPedido(Pedido unPedido) { 

	}
	
	override void comunicar(Comunicable unComunicable) {
		
	}
	
}