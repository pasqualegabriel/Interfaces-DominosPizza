package apiRestAdapters

import estados.Cancelado
import estados.Entregado
import estados.Preparando
import estados.EnViaje
import estados.ListoParaRetirar
import estados.ListoParaEnviar
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EstadoDePedidoApiAdapter {
	
	String nombre
	
	new() {
	}
	
	new(String unNombre) {
		nombre = unNombre
	}
	
	def convertir() {
		todosLosEstados.findFirst[it.nombre.equals(this.nombre)] 
	}
	
	def todosLosEstados(){
		# [new Cancelado	   , new Entregado      , new Preparando, 
		   new ListoParaRetirar, new ListoParaEnviar, new EnViaje
		]
	}
}