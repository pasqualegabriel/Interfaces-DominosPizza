package apiRestAdapters

import pedido.Pedido
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import persistencia.HomeMiembro
import java.time.format.DateTimeFormatter
import java.time.LocalDateTime
import java.time.LocalDate

@Accessors
class PedidoApiAdapter 
{
	Integer 					id
	String					 	estadoActual
	String						miembro
	List<PlatoApiAdapter> 		platos 
	String 						fecha
	String 						aclaracion
	FormaDeRetiroApiAdapter		formaDeRetiro
	Double						monto
	Integer						tiempoDeEspera

	new (){}

	new (Pedido unPedido)
	{
		id		    	= unPedido.id
		tiempoDeEspera	= unPedido.tiempoDeEspera
		aclaracion		= unPedido.aclaracion
		monto			= unPedido.precio
		
		// Se pasa el nick del usuario en vez del usuario entero para evitar la recursion
		// Entre Pedido -1-> Usuario -n-> Pedido
		// De necesitarse el usuario a travez del pedido, se lo puede ir a buscar por el nick.
		miembro		    = unPedido.miembro.nick
		
		// Para mejor manejo y visualizacion, se pasa a String la fecha
		fecha			= unPedido.fecha.toLocalDate.toString
		
		// EstadoActual es una clase abstracta, se pide el nombre y luego se recrea a travez de el.
		estadoActual	= unPedido.estadoActual.nombre
		
		// FormaDeRetiro es una clase abstracta, es mas, las subclases tienen diferente estructura
		// Si la forma de retiro es local, la direccion va a quedar en null.
		formaDeRetiro	= new FormaDeRetiroApiAdapter(unPedido.formaDeRetiro)
		
		// Los platos son entidades complejas, se utiliza un adapter para que 
		// sean mostrables y reconstruibles sin problemas
		platos 		    = newArrayList
		unPedido.platos.forEach[this.platos.add(new PlatoApiAdapter(it))]
		
	}
	
	
	def convertir() {
		// Se va a buscar al miembro
		var unMiembro = HomeMiembro.instance.getMiembro(this.miembro)
		// Se crea el pedido y se lo transforma
		val unPedido = new Pedido(unMiembro)
		
				unPedido.id			    = this.id
				unPedido.aclaracion     = this.aclaracion
				unPedido.tiempoDeEspera = this.tiempoDeEspera
				
				//Se recrea el estado actual
				unPedido.estadoActual   = (new EstadoDePedidoApiAdapter(this.estadoActual)).convertir()
				
				//Se recrean los platos
				this.platos.forEach[unPedido.platos.add(it.convertir)]
				
				//Se convierte la fecha de string a localDateTime
				unPedido.fecha 		    = convertirFecha(this.fecha)
				
				//Se recrea la forma de retiro
				unPedido.formaDeRetiro  = this.formaDeRetiro.convertir
				
		//Se devuelve el pedido transformado	
		unPedido
	}
	
	def convertirFecha(String fecha) {
		var formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDateTime.from(LocalDate.parse(fecha, formatter).atStartOfDay())
	}
	
}