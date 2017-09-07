package ventanaDeIngredientes

import pizza.Ingrediente
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.NumericField

class VentanaDeIngredientes extends SimpleWindow<Ingrediente> {

	new(WindowOwner parent, Ingrediente unIngrediente) {
		super(parent, unIngrediente)
	}

	override protected createFormPanel(Panel mainPanel) {
		this.title = "Ingrediente"

		val editorPanel = new Panel(mainPanel)
		editorPanel.layout = new ColumnLayout(2)

		new Label(editorPanel) => [
			text = "Nombre"
		]
		
		new TextBox(editorPanel) => [
			value <=> "nombre"
		]

		new Label(editorPanel) => [
			text = "Precio"
		]
		new NumericField(editorPanel) => [
			value <=> "precio"
		]

	}

	override protected addActions(Panel actionsPanel) {
	}

}
