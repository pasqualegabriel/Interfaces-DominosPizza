package formasDeComunicacion

import comunicables.Comunicable

import domino.Miembro

// Responsabilidad: Comunicar al usuario mensajes en respuesta a eventos con una estrategia especifica

interface FormaDeComunicacion {
	def void comunicarUsuario(Miembro unMiembro, Comunicable unComunicable)
}