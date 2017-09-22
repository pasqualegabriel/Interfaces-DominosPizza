package menuPizzas

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import pizza.Ingrediente
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.bindings.NotNullObservable

class PanelDeIngredientes extends PanelConListaEditable {

	MenuDeDominoMainWindow mainWindow

	new(Container container, MenuDeDominoMainWindow aMainWindow) {
		super(container)
		mainWindow = aMainWindow
	}

	override initLabel(Panel aPanel) {
		var aLabel = new Label(aPanel).text = "Ingredientes"
		aLabel.alignLeft
	}

	override initList(Panel aPanel) {
		val tablaDePizzas = new Table<Ingrediente>(aPanel, typeof(Ingrediente)) => [
			items <=> "ingredientesDisponibles"
			value <=> "ingredienteSeleccionado"
		]
		new Column(tablaDePizzas) => [
			title = "Nombre"
			fixedSize = 201
			bindContentsToProperty("nombre")
		]
		new Column(tablaDePizzas) => [
			title = "Precio"
			fixedSize = 201
			bindContentsToProperty("precio")
		]
	}

	override initCreateButton(Panel aPanel) {
		new Button(aPanel) => [
			caption = "Crear"

			onClick [
				mainWindow.crearIngrediente
			]
		]
	}

	override initEditButton(Panel aPanel) {
		val habilitadorDeSeleccion = new NotNullObservable("ingredienteSeleccionado")
		new Button(aPanel) => [
			caption = "Edit"

			onClick [
				mainWindow.editarIngrediente
			]
			bindEnabled(habilitadorDeSeleccion)
		]
		
	}

	override initDeleteButton(Panel aPanel) {
		val habilitadorDeSeleccion = new NotNullObservable("ingredienteSeleccionado")
		new Button(aPanel) => [
			caption = "Delete"

			onClick [
				mainWindow.eliminarIngrediente()
				
			]
			bindEnabled(habilitadorDeSeleccion)
		]
	}
}






