package menuPizzas

import org.uqbar.arena.Application

// Esta clase es una application, osea, es la que tiene el main. La window en si la inicia, le setea
// los atributos que necesite como default, y se pasa a si mismo como el window owner

class menuWindowApp extends Application{

	override protected createMainWindow() {
		//Si necesitas que se instancie con algo en especial se lo tiras adentro de los corchetes
		val modelo = new MenuDeDominoAppModel => [
			
		]
		new MenuDeDominoMainWindow(this, modelo) 
	}
	
	def static void main(String[] args) {
		new menuWindowApp().start()
	}
		
}