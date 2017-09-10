package agregarPizza

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.layout.HorizontalLayout
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.RadioSelector

class CheckBoxLabeledSeleccionable extends Panel{
	
	DistribucionAppModel modelo
	
	new(Container container, DistribucionAppModel model) {
		super(container, model)
		modelo = model
		this.init
	}
	
	def init(){
		
		this.layout= new HorizontalLayout
		
		
		new CheckBox(this) => [
   		value <=> "tieneIngrediente"
		]
		
		new Label(this).text= modelo.nombre
		
		new RadioSelector(this) => [
            items <=> "distribuciones"
            value <=> "distribucionSeleccionada"
      ]
	}
}