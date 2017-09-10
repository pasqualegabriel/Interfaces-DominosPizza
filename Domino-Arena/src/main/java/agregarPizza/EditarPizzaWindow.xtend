package agregarPizza

import menuPizzas.MenuDeDominoMainWindow
import org.uqbar.arena.aop.windows.TransactionalDialog
import pizza.Pizza
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import pizza.Ingrediente


class EditarPizzaWindow extends TransactionalDialog<Pizza>{
	
	protected MenuDeDominoMainWindow mainWindow
	
	new(MenuDeDominoMainWindow aMainWindow, Pizza unaPizza) {
		
		super(aMainWindow, unaPizza)
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
			value <=> "precioBase"
			width = 100
		]
		
		this.armarTablaDeIngredientes(mainPanel)
		
	}
	
	def armarTablaDeIngredientes(Panel mainPanel) {
		var tablaDeIngredientes = new Panel(mainPanel)
		tablaDeIngredientes.layout= new VerticalLayout
		var	listaDeIngredientes= mainWindow.modelObject.ingredientesDisponibles
		
		
		for (Ingrediente unIngrediente: listaDeIngredientes ) {
			var distribucion = new DistribucionAppModel(unIngrediente,modelObject)
			new CheckBoxLabeledSeleccionable(tablaDeIngredientes, distribucion)
		}
		
	}
	
	
	def defaultTitle() {
		"Editar Promo"
	}
	
	
}