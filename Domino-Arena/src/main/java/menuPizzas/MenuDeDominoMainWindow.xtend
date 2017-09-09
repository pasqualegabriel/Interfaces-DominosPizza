package menuPizzas

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button

class MenuDeDominoMainWindow  extends SimpleWindow<MenuDeDominoAppModel>{
	
	new(WindowOwner parent, MenuDeDominoAppModel model) {
		super(parent, model)
	}
	
	override protected addActions(Panel actionsPanel) {
		//parte del template method no usada
	}
	
	override protected createFormPanel(Panel mainPanel) {
		//parte del template method no usada
	}
	
	// esta es el panel principal
	override createMainTemplate(Panel mainPanel) {
		// le ponemos el titulo
		this.title = "MenuDomino"
		// decimos que su layout va a ser vertical
		mainPanel.layout = new VerticalLayout
		

		//Agregamos el contenido a nuestro panel que van a ser 2 paneles mas!
		// Como ambos paneles son casi identicos, creamos una clase abstracta que define un template method
		// y los dos paneles que necesitamos lo redefinen a su manera
		new PanelDePromos(mainPanel)
		new PanelDeIngredientes(mainPanel)
		// agregamos el boton para cerrar todo
		new Button(mainPanel) => [
			caption = "cancelar"
			onClick [ this.close]
		]
		
	}
}