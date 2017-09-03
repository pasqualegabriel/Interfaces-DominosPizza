package formasDeComunicacion

import comunicables.Comunicable
import mailSender.GMailSender
import domino.Miembro
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ComunicacionPorMail implements FormaDeComunicacion {

	// Estructura
	GMailSender gmailsender

	// Constructor
	new() {
		gmailsender = GMailSender.config(new GMailSender("ciu.dominos.pizza@gmail.com", "interfaces2017"))

	}

	// Metodos
	override comunicarUsuario(Miembro unUsuario, Comunicable unComunicable) {
		var String mailDelUsuario = unUsuario.mail
		var String titulo = unComunicable.tituloMensaje
		var String cuerpo = unComunicable.cuerpoMensaje
		gmailsender.sendMail(mailDelUsuario, titulo, cuerpo)
	}

}
