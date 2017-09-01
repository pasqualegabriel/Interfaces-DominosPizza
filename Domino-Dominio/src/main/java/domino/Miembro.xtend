package domino

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList
import java.util.List
import pedido.Pedido

/**
 *  Responsabilidad: Representar al usuario cliente registrado en el sistema y manejar
 *  los pedidos que este hizo.
 */
 
@Accessors
class Miembro {
	
	// Estructura
	
	String 			nombre
	String 			nick
	String 			password
	String			mail
	String 			direccion
	List<Pedido>	historialDePedidos
	
	// Constructores
	
	new(String unNombre, String unNick, String unPassword, String unMail, String unaDireccion) {
		
		historialDePedidos= new ArrayList<Pedido>
		nombre			  = unNombre
		nick			  = unNick
		password		  = unPassword
		mail			  = unMail
		direccion		  = unaDireccion
	}
	
	// Metodos
	def agregarPedido(Pedido unPedido) { 
		historialDePedidos.add(unPedido)
	}
	
	
	
}
