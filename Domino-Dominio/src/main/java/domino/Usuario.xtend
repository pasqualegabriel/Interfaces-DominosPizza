package domino

import comunicables.Comunicable
import formasDeComunicacion.FormaDeComunicacion
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: Representacion informatica de los usuarios del servicio junto con sus preferencias

@Accessors
abstract class Usuario {
	// Estructura
	
	FormaDeComunicacion formaDeComunicacion
	
	// Metodo
	
	abstract def void comunicar(Comunicable unaComunicacion)
	
}