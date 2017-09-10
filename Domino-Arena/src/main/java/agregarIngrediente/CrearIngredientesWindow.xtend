package agregarIngrediente

import pizza.Ingrediente
import menuPizzas.MenuDeDominoMainWindow

class CrearIngredientesWindow extends EditarIngredientesWindow {
	
	new(MenuDeDominoMainWindow window) {
		super(window, new Ingrediente("",0) )
	}
	
	override defaultTitle() {
		"Crear Nuevo Ingrediente"
	}
	override void accept(){
		super.accept
		mainWindow.modelObject.agregarIngrediente(super.modelObject)
	}
}