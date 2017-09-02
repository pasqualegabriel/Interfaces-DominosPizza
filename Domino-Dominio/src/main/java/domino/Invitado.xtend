package domino

import comunicables.Comunicable
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Invitado extends Usuario {
	
	override comunicar(Comunicable unaComunicacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}