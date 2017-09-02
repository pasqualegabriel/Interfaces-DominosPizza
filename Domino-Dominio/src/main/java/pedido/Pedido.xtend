package pedido

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import java.time.format.DateTimeFormatter
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
	String 					fecha
	Integer 				montoAPagar
	String 					aclaracion
	FormaDeRetiro 			formaDeRetiro

	// Constructor
	
	new(Miembro unMiembro) {
		
		super()
		estadoActual = new Preparando
		miembro      = unMiembro
		platos       = new ArrayList<Plato>()
		montoAPagar  = 0 /*Pesos*/
		aclaracion   = ""

		var DateTimeFormatter dateformat = DateTimeFormatter.ofPattern("yyy/MM/dd HH:mm:ss")
		var LocalDateTime now            = LocalDateTime.now()
		fecha 							 = dateformat.format(now)

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
		var  precio = 0
		for (p : platos) {
			precio = precio + p.calcularPrecio
		}
		montoAPagar= precio + this.getFormaDeRetiro().precioDeRetiro
	}
	
	def cancelar() {
		estadoActual= new Cancelado
	}

	/**
	 * Retorna True si tardo en entregarse mas de 30 minutos 
	 */	
	def tardoMasDe30Minutos() 
	{
		var fechaAComparar	= LocalDateTime.now
		
		var DateTimeFormatter dateformat = DateTimeFormatter.ofPattern("yyy/MM/dd HH:mm:ss")
		var fechaDePedido = LocalDateTime.parse(this.getFecha,dateformat)	//Convierte el string a local date
		var fechaLimiteSinDemora = fechaDePedido.plusMinutes(30)			//Setea la fecha de pedido con 30 minutos adelantados
		
		fechaAComparar.isAfter(fechaLimiteSinDemora)	//Se fija si unaFecha es superior a la fecha de pedido
	}

}

