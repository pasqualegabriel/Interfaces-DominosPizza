package app

import persistencia.Bootstrap
import org.uqbar.xtrest.api.XTRest
import restApi.DominoRestApi

class DominoApp {

	
	def static void main(String[] args) {
		val bootstrap = new Bootstrap
		bootstrap.inicializar
        XTRest.startInstance(1500, new DominoRestApi())
    }
	

}