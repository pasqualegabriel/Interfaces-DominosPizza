package pedido

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import pizza.Ingrediente
import persistencia.Home


abstract class EditarIngredienteTemplate extends TransactionalDialog<Object>{
	
	new(WindowOwner owner, Object model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		this.title = this.defaultTitle
		
		// Se declara en forma de Template Metod para hacer la extension mas comoda
		
		this.initHead(mainPanel)
		this.armarTablaDeIngredientes(mainPanel)
		this.initBottom(mainPanel)
	}
	
	def String defaultTitle()
	
	def void initHead(Panel mainPanel)
	
	def void initBottom(Panel mainPanel)
	

// Los problemas empiezan por culpa de esto. Vos necesitas una Checkbox con selector
// Por cada uno de los ingredientes que haya disponible. No hay otra forma que hacerlo que con un for
// Esta parte no me parece que este mal, la parte que me parece mal es la de createCheckBox

	def armarTablaDeIngredientes(Panel mainPanel) {
		var tablaDeIngredientes = new Panel(mainPanel)
		tablaDeIngredientes.layout= new VerticalLayout
		var	listaDeIngredientes= Home.instance.getIngredientesDisponibles()
		
		
		for (Ingrediente unIngrediente: listaDeIngredientes ) {
			this.createCheckBoxLabeledSeleccionable(tablaDeIngredientes, unIngrediente)
		}
		
	}
		

	def void createCheckBoxLabeledSeleccionable(Panel tablaDeIngredientes,Ingrediente unIngrediente)
}