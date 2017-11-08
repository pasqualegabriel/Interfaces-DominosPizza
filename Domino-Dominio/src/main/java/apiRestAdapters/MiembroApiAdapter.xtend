package apiRestAdapters

import java.util.List
import domino.Miembro
import persistencia.HomeMiembro
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class MiembroApiAdapter {
	
	String 						nombre
	String 						nick
	String 						password
	String						mail
	String 						direccion
	List<PedidoApiAdapter>    	historialDePedidos
	
	new (){}
	
	new(Miembro miembro) {
		nombre 			         = miembro.nombre
		nick  			         = miembro.nick
		password 				 = miembro.password
		mail 				     = miembro.mail
		direccion				 = miembro.direccion
		historialDePedidos 		 = newArrayList
		miembro.historialDePedidos.forEach[this.historialDePedidos.add(new PedidoApiAdapter(it))]
	}
	
	def realizarModificaciones() {
		
		var miembro 		= HomeMiembro.instance.getMiembro(nick)
		miembro.nombre		= this.nombre
		miembro.mail		= this.mail
		miembro.direccion 	= this.direccion
	}
	/* 
	def convertir() {
		val miembro = new Miembro
				miembro.nombre	           = this.nombre
				miembro.nick               = this.nick
				miembro.password           = this.password
				miembro.mail               = this.mail
				miembro.direccion  	       = this.direccion
				this.historialDePedidos.forEach[miembro.historialDePedidos.add(it.convertir)]
			
		miembro 
	}*/
	
	/*Metodo utilizado a la hora de registrarse un nuevo usuario desde la web. Adapta los datos obtenidos para ser utilizados en una clase miembro, compatible con el dominio*/
	def crearNuevoMiembro()
	{
		return new Miembro(this.nombre, this.nick, this.password, this.mail, this.direccion)
	}
	
}