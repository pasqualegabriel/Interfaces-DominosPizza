package menuPizzas

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout

abstract class PanelConListaEditable extends Panel {
	
	new(Container container) {
		super(container)
		this.initLayout	
		// Tanto el Panel con lista como el panel con los botones de edicion
		// Se inician y setean en el constructor
		// por que son parte de la identidad del objeto
		// no tiene sentido u panel con lista editable si no tiene un panel con una lista y los botones
		// de edicion
		
		val Panel panelWithList = new Panel(this)
		val Panel panelWithButtons= new Panel(this)
		
		// el template method viene a hacer juego en como se define esa lista y esos botones	
		
		this.initLabeledList(panelWithList)
		this.initButtons(panelWithButtons)
	}
	
	def void initLayout(){
		//Le decimos que layout va a tener, que es horizontal
		this.layout = new HorizontalLayout
	}
	
	
	def void initLabeledList(Panel aPanel){
		// Para iniciar la lista se setea el layout
		aPanel.layout = new VerticalLayout()
		// Se colocan la label y la lista que tienen que redefinir las subclases
		this.initLabel(aPanel)
		this.initList(aPanel)
		
	}
	
	def abstract void initLabel(Panel aPanel)
	
	def abstract void initList(Panel aPanel)
	
	def void initButtons(Panel aPanel){
		// Se Setea el Layout
		aPanel.layout = new VerticalLayout()
		
		// Se inician los botones que tienen que redefinir las subclases
		this.initCreateButton(aPanel)
		this.initEditButton(aPanel)
		this.initDeleteButton(aPanel)
	}
	
	def abstract void initCreateButton(Panel aPanel)
	
	def abstract void initEditButton(Panel aPanel)
	
	def abstract void initDeleteButton(Panel aPanel)
	
}