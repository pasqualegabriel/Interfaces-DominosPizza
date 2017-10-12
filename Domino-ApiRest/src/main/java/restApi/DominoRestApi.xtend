package restApi

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import persistencia.HomePizza
import persistencia.HomeTamanio
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Post
import domino.Miembro
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import persistencia.HomeMiembro
import persistencia.HomeIngrediente
import persistencia.HomePedido
import apiRestAdapters.PedidoApiAdapter
import pedido.Pedido
import domino.Login
import persistencia.HomeLogin
import org.uqbar.xtrest.api.annotation.Put

@Controller
class DominoRestApi {

	extension JSONUtils = new JSONUtils

	@Get("/pizzas")
	def getPizzas(String string) {
		response.contentType = ContentType.APPLICATION_JSON
		ok(HomePizza.instance.searchPromos(string).toJson)
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
		// falta hacer un adapter, y contemplar si hace falta id
		ok(HomeMiembro.instance.searchUsuario(string).toJson)
	}

	// los miembros no tienen id, asi que lo estoy buscnado por nombre, hay que contemplar si hace falta id
	@Put("/usuarios/:nombre")
	def getUsuario(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var Miembro muestraDeUsuarioParaEditar = body.fromJson(Miembro)
			try {
				var user = HomeMiembro.instance.getMiembro(nombre)
				// Preguntarse quien deberia tener esta responsabilidad
				HomeMiembro.instance.modificarMiembroPorEjemplo(muestraDeUsuarioParaEditar, user)
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
			var Miembro user = body.fromJson(Miembro)
			try {
				HomeMiembro.instance.registrarUsuario(user)
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
			var pedidosAMostrar = HomePedido.instance.searchPedidosPorNombreUsuario(usuario).map [ p |
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
			var Pedido unPedido = body.fromJson(Pedido)
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

// preguntar   por este, en el tp dice que es un post, pero esta modificando un pedido, no seria un put?
//     @Post("/pedidos/:id")
//    def cambiarEstadoDePedido(@Body String body) {
//       
//    }
	@Get("/pedidos/:id")
	def getPedidoPorId() {
		response.contentType = ContentType.APPLICATION_JSON
		try {
			var unPedido = HomePedido.instance.getPedido(Integer.valueOf(id))
			if (unPedido == null) {
				return notFound(getErrorJson("No existe pedido con ese id"))
			} else {
				return ok(unPedido.toJson)
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
				return ok(unPedido.estadoActual.toJson)
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
				HomeLogin.instance.registrarLogin(unLogin)
				ok()
			} catch (UserException exception) {
				badRequest(getErrorJson(exception.message))
			}
		} catch (UnrecognizedPropertyException exception) {
			badRequest(getErrorJson("El body debe ser un Login"))
		}
	}

}
