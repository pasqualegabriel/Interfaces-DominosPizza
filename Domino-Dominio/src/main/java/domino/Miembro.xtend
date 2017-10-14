package domino

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pedido.Pedido
import comunicables.Comunicable
import formasDeComunicacion.ComunicacionPorMail
import formasDeComunicacion.FormaDeComunicacion
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import java.util.ArrayList

/**
 *  Responsabilidad: Representar al usuario cliente registrado en el sistema y manejar
 *  los pedidos que este ya hizo ademas de las preferencias de este.
 */
 
@Accessors
@TransactionalAndObservable
class Miembro extends Usuario {
	
	// Estructura
	
	String 				nombre
	String 				nick
	String 				password
	String				mail
	String 				direccion
	List<Pedido>    	historialDePedidos = newArrayList
	FormaDeComunicacion formaDeComunicacion
	
	// Constructores
	
	new(){
		super()
	}
	
	new(String unNombre, String unNick, String unPassword, String unMail, String unaDireccion) {
		
		historialDePedidos  = new ArrayList<Pedido>
		nombre			    = unNombre
		nick			    = unNick
		password		    = unPassword
		mail			    = unMail
		direccion		    = unaDireccion
		formaDeComunicacion = new ComunicacionPorMail

	}
	
	// Metodos
	def agregarPedido(Pedido unPedido) { 
		
		historialDePedidos.add(unPedido)
	}

	override comunicar(Comunicable unComunicable) {
		
		formaDeComunicacion.comunicarUsuario(this, unComunicable)
	}
	
	def listaHistorialDePedidos(){
		val listaDePedidos = newArrayList
		historialDePedidos.forEach[listaDePedidos.add(it)]
		listaDePedidos
	}
	
	
}
