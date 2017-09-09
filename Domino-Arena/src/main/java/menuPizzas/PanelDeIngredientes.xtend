package menuPizzas

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import pizza.Ingrediente

class PanelDeIngredientes extends PanelConListaEditable {
	
	new(Container container) {
		super(container)
	}
	
	override initLabel(Panel aPanel) {
		var aLabel = new Label(aPanel).text="Ingredientes"
		aLabel.alignLeft
	}
	
	override initList(Panel aPanel) {
		val tablaDePizzas = new Table<Ingrediente>(aPanel, typeof(Ingrediente)) => [
 		   items <=> "ingredientesDisponibles"
    	   value <=> "ingredienteSeleccionado"	
		]
		new Column(tablaDePizzas) =>[
			title = "Nombre"
			fixedSize = 200
			bindContentsToProperty("nombre")
			]
		new Column(tablaDePizzas) =>[
			title = "Precio"
			fixedSize = 200
			bindContentsToProperty("precio")
		]
	}
	
	override initCreateButton(Panel aPanel) {
			new Button(aPanel) => [
			caption = "Crear"
			
			onClick [ | ]
			]
	}
	
	override initEditButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Edit"
			
			onClick [ | ]
			]
	}
	
	override initDeleteButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Delete"
			
			onClick [ | ]
			]
	}
}