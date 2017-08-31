import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import java.time.format.DateTimeFormatter
import java.time.LocalDateTime

@Accessors
class Pedido {

	// Proposito: Pendiente para escribir
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
		miembro = unMiembro
		platos = new ArrayList<Plato>()
		montoAPagar = 0 /*Pesos*/
		aclaracion = ""

		var DateTimeFormatter dateformat = DateTimeFormatter.ofPattern("yyy/MM/dd HH:mm:ss")
		var LocalDateTime now = LocalDateTime.now()
		fecha = dateformat.format(now)

	}

	// Metodos
	def cambiarAclaracion(String aclaracionNueva) {
		aclaracion = aclaracionNueva
	}

	def agregarPlato(Plato plato) {
		platos.add(plato)
	}

	def quitarPlato(Plato plato) {
		platos.remove(plato)
	}

	def calcularPrecio() {
		var  precio = 0
		for (p : platos) {
			precio = precio + p.calcularPrecio
		}
		montoAPagar= precio
	}
	
	def cancelar() {
		estadoActual= new Cancelado
	}

}

