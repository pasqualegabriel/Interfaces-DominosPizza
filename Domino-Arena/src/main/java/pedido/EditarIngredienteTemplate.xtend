package pedido

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import pizza.Ingrediente
import persistencia.Home
import agregarPizza.IngredienteAdapter
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.widgets.RadioSelector
import agregarPizza.IngredienteAdapterAbstract

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

// Esto hay que preguntarlo o rehacerlo.
// No pude encontrar otra manera de hacerlo por la naturaleza del checkbox, necesita contraponerse contra
// algo que de un bool, y no encontre como hacerlo funcionar contra un map tampoco.
// El problema es que al parecer se pierde la transaccionalidad asi, lo cual no deberia pasar.

// El segundo problema esta en que el enabled no parece funcionar por alguna razon.

	
	def createCheckBoxLabeledSeleccionable(Panel tablaDeIngredientes,Ingrediente unIngrediente){
		val ingredienteAppModel = this.getAdapter(unIngrediente)
      	var checkBoxDeIngrediente = new Panel(tablaDeIngredientes)
      	checkBoxDeIngrediente.setLayout = new HorizontalLayout	
      
		new CheckBox(checkBoxDeIngrediente).bindValue(new ObservableProperty(ingredienteAppModel, "estaActivadoEnCheckbox"))
		
		new Label(checkBoxDeIngrediente).text= unIngrediente.nombre
		
		val radio = new RadioSelector(checkBoxDeIngrediente)
//		radio.bindEnabled(new ObservableProperty(ingredienteAppModel, "estaActivadoEnCheckbox"))
		radio.bindItems(new ObservableProperty(ingredienteAppModel, "distribuciones"))
		radio.bindValue(new ObservableProperty(ingredienteAppModel, "distribucionSeleccionada"))
	}
	
	def IngredienteAdapterAbstract getAdapter(Ingrediente unIngrediente)
}