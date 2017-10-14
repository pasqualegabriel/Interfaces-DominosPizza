package pedido

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import java.time.LocalDateTime
import estados.Preparando
import domino.Miembro
import estados.EstadoDePedido
import estados.Cancelado
import java.time.LocalTime
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import persistencia.HomePedido
import org.uqbar.commons.model.annotations.Dependencies

/**
 *  Responsabilidad: - Contener los platos de un pedido en especifico.
 * 					 - Expresar el estado de la preparacion de ese pedido.
 * 					 - Manejar datos de interes respecto aquella misma orden.
 */
 
@TransactionalAndObservable
@Accessors
class Pedido {

	// Estructura
	
	Integer					id
	
	EstadoDePedido 			estadoActual
	Miembro 				miembro
	List<Plato> 			platos 
	LocalDateTime 			fecha
	String 					aclaracion
	FormaDeRetiro 			formaDeRetiro
	Integer					tiempoDeEspera
	
	// Constructor
	new(Miembro unMiembro) {
		
		super()
		estadoActual = new Preparando
		miembro      = unMiembro
		platos       = new ArrayList<Plato>
		aclaracion   = ""
		fecha        = LocalDateTime.now()
		this.tiempoDeEspera = 0
		formaDeRetiro = new Local
		
	}
	
	
	def cambiarAclaracion(String aclaracionNueva) {
		aclaracion = aclaracionNueva
	}
	
	// Precondicion: El plato tiene que ser un plato que no este ya en la lista de platos
	def void agregarPlato(Plato plato) {
		platos.add(plato)
	}
	
	// Precondicion: El plato tiene que estar en la lista de platos
	def quitarPlato(Plato plato) {
		platos.remove(plato)
	}	
	
	def cancelar() {
		estadoActual= new Cancelado
	}

	/**
	 * Retorna True si tardo en entregarse mas de 30 minutos 
	 */	
	def tardoMasDe30Minutos() 
	{
		this.tiempoDeEspera >= 30
	}
	
	def calcularTiempoDeEntrega() 
	{
		this.tiempoDeEspera = Math.abs(LocalTime.now.toSecondOfDay - fecha.toLocalTime.toSecondOfDay) / 60
	}
	
	def siguiente(){
		estadoActual.siguiente(this)
	}
	def anterior(){
		estadoActual.anterior(this)
	}
	
	def agregarAlHistorial() {
		miembro.agregarPedido(this)
	}

	def estaCerrado()
	{
		estadoActual.estaCerrado
	}
	
	def estaPreparando()
	{
		estadoActual.estaPreparando
	}
	def estaEntregado(){
		estadoActual.estaEntregado
	}
	
	def cambiarAEstado(estados.EstadoDePedido pedido) {
		/**Se fija si el estado a cambiar es al estado entregado, 
		 * si es asi lo mueve a la lista de pedidos cerrados y calcula el tiempo de entrega*/
		if (this.estadoActual.estaEntregado) {
			this.calcularTiempoDeEntrega
			this.agregarAlHistorial
			HomePedido.instance.moverPedidoAPedidosCerrado(this)
		}
	}
	
	def cerrarPedido() {
		agregarAlHistorial
		HomePedido.instance.moverPedidoAPedidosCerrado(this)
		
	}
	
	def costoDeRetiro()
	{
		this.formaDeRetiro.precioDeRetiro	
	}
	
	@Dependencies("platos","formaDeRetiro")
	def getPrecio() {
		platos.stream.mapToDouble[it.getPrecio].sum + this.formaDeRetiro.precioDeRetiro	
	}
}

