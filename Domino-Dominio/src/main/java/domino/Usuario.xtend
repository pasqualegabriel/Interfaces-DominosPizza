package domino

import comunicables.Comunicable
import formasDeComunicacion.FormaDeComunicacion
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Usuario {
	// Estructura
	
	FormaDeComunicacion formaDeComunicacion
	
	// Metodo
	
	abstract def void comunicar(Comunicable unaComunicacion)
	
}