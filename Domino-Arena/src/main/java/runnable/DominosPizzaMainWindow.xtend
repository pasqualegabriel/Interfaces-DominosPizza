package runnable

//import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.graphics.Image
import org.uqbar.arena.widgets.Button

import DominoPizzaInicio.DominoPizzaWindow

class DominosPizzaMainWindow extends Window<ImagenDominosPizza> {

	new(WindowOwner owner, ImagenDominosPizza model) {
		super(owner, model)
	}

	override createContents(Panel mainPanel) {
		
		title = "Dominos Pizza"
		
		new Label(mainPanel) => [
			bindImageToProperty("imagen", [ imagen |
				new Image(imagen)
			])
		]

		new Button(mainPanel) => [
			caption = "Ingresar"
			onClick [new DominoPizzaWindow(this).open]
		]

	}

}
