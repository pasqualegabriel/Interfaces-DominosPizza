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

@Controller
class DominoRestApi {
	
	  extension JSONUtils = new JSONUtils
	
	    
    
    	  
	@Get("/pizzas")
    def getPizzas(String string) {
        response.contentType = ContentType.APPLICATION_JSON
        ok(HomePizza.instance.searchPromos(string).toJson)
    }
    
    @Get("/tamanios")
    def getTamanios(String string){
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(HomeTamanio.instance.searchTamanios(string).toJson)
    	
    }
    
    def private getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }
    	  
	@Get("/usuarios")
    def getUsuario(String string) {
        response.contentType = ContentType.APPLICATION_JSON
        ok(HomeMiembro.instance.searchUsuario(string).toJson)
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
    def getIngredientes(String string)
    {
    	response.contentType = ContentType.APPLICATION_JSON
        ok(HomeIngrediente.instance.searchIngrediente(string).toJson)
    }
    
    @Get("/pedidos")
    def getPedidoPorEstado(String estado)
    {
    	response.contentType = ContentType.APPLICATION_JSON
    	var pedidoAMostrar	= HomePedido.instance.searchPedidoPorEstado(estado).map[ p | new PedidoApiAdapter(p) ].toArray
        ok(pedidoAMostrar.toJson)
    }
}




