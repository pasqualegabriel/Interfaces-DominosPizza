package menuPizzas

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import pizza.Pizza
import org.uqbar.arena.widgets.Button

class PanelDePromos extends PanelConListaEditable {
	
	
	MenuDeDominoMainWindow mainWindow
		
	new(Container container, MenuDeDominoMainWindow aMainWindow) {
		super(container)
		mainWindow = aMainWindow
	}
	
	
	
	override initLabel(Panel aPanel) {
		var aLabel = new Label(aPanel).text="Promociones"
		aLabel.alignLeft
	}
	
	override initList(Panel aPanel) {
		val tablaDePizzas = new Table<Pizza>(aPanel, typeof(Pizza)) => [
 		   items <=> "promosDisponibles"
    	   value <=> "pizzaSeleccionada"	
		]
		new Column(tablaDePizzas) =>[
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("nombre")
			]
		new Column(tablaDePizzas) =>[
			title = "Precio"
			fixedSize = 200
			bindContentsToProperty("precioBase")
		]
	}
	
	override initCreateButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Crear"
			//mainWindow.crearPizza()
			onClick [ | ]
		]
	}
	
	override initEditButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Edit"
			onClick [ | mainWindow.editarPizza() ]
			]

	}
	
	override initDeleteButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Delete"
			onClick [ | mainWindow.eliminarPizza()  ]
			]
	}
	
}