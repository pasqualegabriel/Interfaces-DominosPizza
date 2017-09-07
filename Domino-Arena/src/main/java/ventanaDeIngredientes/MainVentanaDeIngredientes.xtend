package ventanaDeIngredientes

import pizza.Ingrediente
import org.uqbar.arena.Application

class MainVentanaDeIngredientes extends Application {
	override protected createMainWindow() {
		new VentanaDeIngredientes(this, new Ingrediente("", 0))
	}
	
		def static main(String[] args) {

		new MainVentanaDeIngredientes().start
	}

}
