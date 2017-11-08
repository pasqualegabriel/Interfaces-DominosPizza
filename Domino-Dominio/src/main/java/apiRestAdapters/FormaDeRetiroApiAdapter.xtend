package apiRestAdapters

import org.eclipse.xtend.lib.annotations.Accessors
import pedido.FormaDeRetiro
import pedido.Local
import pedido.Delivery

@Accessors
class FormaDeRetiroApiAdapter {
	
	String tipo
	String direccion
	Double precio
	
	new(){}
	
	new(FormaDeRetiro formaDeRetiro) {
		tipo	= formaDeRetiro.tipo
		precio	= formaDeRetiro.precioDeRetiro
		if (tipo.equals("Delivery")) putDirection(formaDeRetiro)
	}
	
	def putDirection(FormaDeRetiro retiro) {
		var delivery = retiro as Delivery
		direccion = delivery.direccion
	}
	
	def convertir() {
		if (tipo.equals("Delivery")) return (new Delivery(direccion)) 
		else return new Local 
	}
	
}