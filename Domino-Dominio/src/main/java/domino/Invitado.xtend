package domino

import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: Representar a un usuario cliente
@Accessors
class Invitado extends Usuario {
	
	override comunicar(Comunicable unaComunicacion) {
		// Seguramente la forma de comunicacion con un cliente invitado va a ser a travez de una ventana
		// Cuando veamos en clase como hacerlo lo implementamos.
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}