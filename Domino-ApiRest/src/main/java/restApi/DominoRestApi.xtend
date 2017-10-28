package restApi

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import persistencia.HomePizza
import persistencia.HomeTamanio
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import persistencia.HomeMiembro
import persistencia.HomeIngrediente
import persistencia.HomePedido
import apiRestAdapters.PedidoApiAdapter
import domino.Login
import persistencia.HomeLogin
import org.uqbar.xtrest.api.annotation.Put
import apiRestAdapters.MiembroApiAdapter
import apiRestAdapters.EstadoDePedidoApiAdapter
import apiRestAdapters.PizzaApiAddapter

@Controller
class DominoRestApi {

	extension JSONUtils = new JSONUtils

	@Get("/pizzas")
	def getPizzas(String string) {
		response.contentType = ContentType.APPLICATION_JSON
		var pizzas = HomePizza.instance.searchPromos(string).map[m|new PizzaApiAddapter(m)].toArray
		ok(pizzas.toJson)
	}

	@Get("/tamanios")
	def getTamanios(String string) {
		response.contentType = ContentType.APPLICATION_JSON
		ok(HomeTamanio.instance.searchTamanios(string).toJson)

	}

	def private getErrorJson(String message) {
		'{ "error": "' + message + '" }'
	}

	@Get("/usuarios")
	def getUsuario(String string) {
		response.contentType = ContentType.APPLICATION_JSON
		var miembros = HomeMiembro.instance.searchUsuario(string).map[m|new MiembroApiAdapter(m)].toArray
		ok(miembros.toJson)
	}
	
	@Get("/usuarios/:nick")
	def getUsuariobyNick() {
		response.contentType = ContentType.APPLICATION_JSON
		var miembro = new MiembroApiAdapter(HomeMiembro.instance.getMiembro(nick))
		ok(miembro.toJson)
	}
	

	@Put("/usuarios/:nick")
	def getUsuario(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var MiembroApiAdapter miembro = body.fromJson(MiembroApiAdapter)
			try {
				miembro.nick= nick
				miembro.realizarModificaciones
				ok()
			} catch (UserException exception) {
				badRequest(getErrorJson(exception.message))
			}
		} catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Usuario"))
		}

	}

	@Post("/usuarios")
	def createUsuario(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var MiembroApiAdapter miembroAdapter = body.fromJson(MiembroApiAdapter)
			var miembro = miembroAdapter.convertir
			try {
				HomeMiembro.instance.registrarUsuario(miembro)
				ok()
			} catch (UserException exception) {
				badRequest(getErrorJson(exception.message))
			}
		} catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Usuario"))
		}
	}

	@Get("/ingredientes")
	def getIngredientes(String string) {
		response.contentType = ContentType.APPLICATION_JSON
		ok(HomeIngrediente.instance.searchIngrediente(string).toJson)
	}

	@Get("/pedidos")
	def getPedidoPorEstado(String estado) {
		response.contentType = ContentType.APPLICATION_JSON
		var pedidoAMostrar = HomePedido.instance.searchPedidoPorEstado(estado).map[p|new PedidoApiAdapter(p)].toArray
		ok(pedidoAMostrar.toJson)
	}

	@Get("/pedidos")
	def getPedidoPorUsuario(String usuario) {
		try {
			response.contentType = ContentType.APPLICATION_JSON
			var pedidosAMostrar = HomePedido.instance.searchPedidosPorNickUsuario(usuario).map [ p |
				new PedidoApiAdapter(p)
			].toArray
			ok(pedidosAMostrar.toJson)
		} catch (UserException exception) {
			badRequest(getErrorJson("Introduzca un id valido"))
		}
	}

	@Post("/pedidos")
	def createPedido(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var PedidoApiAdapter unPedidoApiAdapter = body.fromJson(PedidoApiAdapter)
			var unPedido = unPedidoApiAdapter.convertir
			try {
				HomePedido.instance.agregarPedido(unPedido)
				ok()
			} catch (UserException exception) {
				badRequest(getErrorJson(exception.message))
			}
		} catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Pedido"))
		}
	}

    @Post("/pedidos/:id")
    def cambiarEstadoDePedido(@Body String body) {
       response.contentType = ContentType.APPLICATION_JSON
      
       try {
    	   var EstadoDePedidoApiAdapter unEstadoAdapter = body.fromJson(EstadoDePedidoApiAdapter)
      	   var unEstado = unEstadoAdapter.convertir 
      	   if (unEstado == null) return badRequest(getErrorJson("No existe un estado con ese nombre"))
	  	   
		   val unPedido = HomePedido.instance.getPedido(Integer.valueOf(id))
		   if (unPedido == null) return notFound(getErrorJson("No existe pedido con ese id"))
		   unPedido.estadoActual = unEstado
		   ok() 
	   }
	    catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Estado"))
		}
    }
    
    
	@Get("/pedidos/:id")
	def getPedidoPorId() {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var unPedido = HomePedido.instance.getPedido(Integer.valueOf(id))
			if (unPedido == null) {
				return notFound(getErrorJson("No existe pedido con ese id"))
			} else {
				var pedidoAdaptado = new PedidoApiAdapter(unPedido)
				return ok(pedidoAdaptado.toJson)
			}
		} catch (NumberFormatException exception) {
			return badRequest(getErrorJson("El id debe ser un numero entero"))
		}
	}

	@Get("/pedidos/:id/estado")
	def getEstadoDePedido() {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var unPedido = HomePedido.instance.getPedido(Integer.valueOf(id))
			if (unPedido == null) {
				return notFound(getErrorJson("No existe pedido con ese id"))
			} else {
				var unEstadoAdaptado = new EstadoDePedidoApiAdapter(unPedido.estadoActual.nombre)
				return ok(unEstadoAdaptado.toJson)
			}
		} catch (NumberFormatException exception) {
			return badRequest(getErrorJson("El id debe ser un numero entero"))
		}
	}

	@Post("/login")
	def createLogin(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var Login unLogin = body.fromJson(Login)
			try {
//				HomeLogin.instance.registrarLogin(unLogin)
				var MiembroApiAdapter usuario =  new MiembroApiAdapter(HomeLogin.instance.verificarLogin(unLogin))
				ok(usuario.toJson)
			} catch (UserException exception) {
				badRequest(getErrorJson(exception.message))
			}
		} catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Login"))
		}
	}


}
