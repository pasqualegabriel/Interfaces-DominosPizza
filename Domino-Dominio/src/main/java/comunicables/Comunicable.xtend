package comunicables

// Responsabilidad: Contener la informacion y estructura de mensajes que el sistema necesita
//           		comunicarle al usuario al darse ciertos eventos

interface Comunicable {
	
	def String tituloMensaje()
	
	def String cuerpoMensaje()
}