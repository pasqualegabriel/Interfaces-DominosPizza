package restApi

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import persistencia.HomePizza
import persistencia.HomeTamanio

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
	
}