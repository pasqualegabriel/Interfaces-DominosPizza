package agregarPizza

import menuPizzas.MenuDeDominoMainWindow
import pizza.Pizza
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import pizza.Ingrediente
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.RadioSelector
import org.uqbar.arena.widgets.Button
import pedido.EditarIngredienteTemplate
import org.uqbar.arena.bindings.ObservableProperty

class EditarPizzaWindow extends EditarIngredienteTemplate{
	
	protected MenuDeDominoMainWindow mainWindow
	protected Pizza model
	
	new(MenuDeDominoMainWindow aMainWindow, Pizza unaPizza) {
		
		super(aMainWindow, unaPizza)
		model = unaPizza
		mainWindow = aMainWindow
	}
	
	
	override initHead(Panel mainPanel) {
		new Label(mainPanel).text = "Nombre"
		new TextBox(mainPanel) => [
			value <=> "nombre"
			width = 100
		]
		
		new Label(mainPanel).text = "Precio"
		new TextBox(mainPanel) => [
			value <=> "precioBase"
			width = 100
		]
	}
	
	override getAdapter(Ingrediente unIngrediente) {
		new IngredienteAdapter(unIngrediente, model)
	}
	
	override initBottom(Panel mainPanel) {
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.accept]
			
			disableOnError	
		]
		new Button(mainPanel) => [
			caption = "Cancelar"	
			onClick [|
				this.cancel
			]
		]
	}
	
	override defaultTitle() {
		"Editar Promo"
	}
	
	
}