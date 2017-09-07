package pedido

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import java.time.LocalDateTime
import java.util.Observable
import estados.Preparando
import domino.Miembro
import estados.EstadoDePedido
import estados.Cancelado

/**
 *  Responsabilidad: - Contener los platos de un pedido en especifico.
 * 					 - Expresar el estado de la preparacion de ese pedido.
 * 					 - Manejar datos de interes respecto aquella misma orden.
 */
 
@Accessors
class Pedido extends Observable {

	// Estructura
	
	EstadoDePedido 			estadoActual
	Miembro 				miembro
	List<Plato> 			platos
	LocalDateTime 			fecha
	String 					aclaracion
	FormaDeRetiro 			formaDeRetiro

	// Constructor
	
	new(Miembro unMiembro) {
		
		super()
		estadoActual = new Preparando
		miembro      = unMiembro
		platos       = new ArrayList<Plato>()
		aclaracion   = ""
		fecha        = LocalDateTime.now()
		

	}
	


	// Metodos
	
	def cambiarAclaracion(String aclaracionNueva) {
		aclaracion = aclaracionNueva
	}
	
	// Precondicion: El plato tiene que ser un plato que no este ya en la lista de platos
	def agregarPlato(Plato plato) {
		platos.add(plato)
	}
	
	// Precondicion: El plato tiene que estar en la lista de platos
	def quitarPlato(Plato plato) {
		platos.remove(plato)
	}

	def calcularPrecio() {
		val precioPlatos = platos.stream.mapToInt[it.calcularPrecio].sum()
		precioPlatos + formaDeRetiro.precioDeRetiro
	}
	
	def cancelar() {
		estadoActual= new Cancelado
	}

	/**
	 * Retorna True si tardo en entregarse mas de 30 minutos 
	 */	
	def tardoMasDe30Minutos() 
	{
		fecha.minusMinutes(30).isAfter(LocalDateTime.now) || fecha.minusMinutes(30).equals(LocalDateTime.now)
	}

}

