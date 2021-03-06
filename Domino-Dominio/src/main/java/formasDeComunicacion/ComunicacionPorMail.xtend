package formasDeComunicacion

import comunicables.Comunicable
import mailSender.GMailSender
import domino.Miembro
import org.eclipse.xtend.lib.annotations.Accessors

// Responsabilidad: Comunicar al usuario a travez de mail ciertos mensajes que el sistema necesita hacerle
//           		llegar cuando suceden ciertos eventos

@Accessors
class ComunicacionPorMail implements FormaDeComunicacion {

	// Estructura
	int         id
	GMailSender gmailsender

	// Constructor
	new() {
		super()
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
