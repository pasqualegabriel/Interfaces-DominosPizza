package agregarIngrediente

import pizza.Ingrediente
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.VerticalLayout
import menuPizzas.MenuDeDominoMainWindow

class EditarIngredientesWindow extends TransactionalDialog<Ingrediente>{
	
	protected MenuDeDominoMainWindow mainWindow
	
	new(MenuDeDominoMainWindow aMainWindow, Ingrediente model) {
		super(aMainWindow, model)
		mainWindow = aMainWindow
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		mainPanel.layout = new VerticalLayout
		this.title = this.defaultTitle
	
		new Label(mainPanel).text = "Nombre"
		new TextBox(mainPanel) => [
			value <=> "nombre"
			width = 100
		]
		
		new Label(mainPanel).text = "Precio"
		new TextBox(mainPanel) => [
			value <=> "precio"
			width = 100
		]
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.accept
					   mainWindow.modelObject.actualizarIngredientesDisponibles
				
			]
			
			disableOnError	
		]
		new Button(mainPanel) => [
			caption = "Cancelar"	
			onClick [|
				this.cancel
			]
		]
	}
	
	def defaultTitle() {
		"Editar Ingrediente"
	}
	
	
}