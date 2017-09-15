package pedido

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import pizza.Ingrediente
import persistencia.Home
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.widgets.RadioSelector
import agregarPizza.IngredienteAdapterAbstract
import org.uqbar.arena.widgets.Selector
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

abstract class EditarIngredienteTemplate extends TransactionalDialog<Object>{
	
	new(WindowOwner owner, Object model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		
		// Se declara en forma de Template Metod para hacer la extension mas comoda
		
		this.initHead(mainPanel)
		this.armarTablaDeIngredientes(mainPanel)
		this.initBottom(mainPanel)
	}
	
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
	
	def createCheckBoxLabeledSeleccionable(Panel tablaDeIngredientes,Ingrediente unIngrediente){
		val ingredienteAppModel = this.getAdapter(unIngrediente)
		this.agregarAModelo(ingredienteAppModel)
		
		
      	var checkBoxDeIngrediente = new Panel(tablaDeIngredientes, ingredienteAppModel)
      	checkBoxDeIngrediente.setLayout = new HorizontalLayout	
      	
      
		new CheckBox(checkBoxDeIngrediente)=>[
			value <=>"estaActivadoEnCheckbox"
		]
	
		new Label(checkBoxDeIngrediente).text= unIngrediente.nombre
		
		new Selector(checkBoxDeIngrediente)=>[
     		allowNull(false)	
			items <=> "distribuciones"
			value <=> "distribucionSeleccionada"
		]
	}
	
	def void agregarAModelo(IngredienteAdapterAbstract abstract1)
	
	def IngredienteAdapterAbstract getAdapter(Ingrediente unIngrediente)
}