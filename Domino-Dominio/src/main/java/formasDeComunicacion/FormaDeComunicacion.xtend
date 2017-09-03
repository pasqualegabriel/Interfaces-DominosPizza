package formasDeComunicacion

import comunicables.Comunicable

import domino.Miembro

interface FormaDeComunicacion {
	def void comunicarUsuario(Miembro unMiembro, Comunicable unComunicable)
}