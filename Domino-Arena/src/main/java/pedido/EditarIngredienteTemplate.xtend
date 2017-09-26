package pedido

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import pizza.Ingrediente
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import agregarPizza.IngredienteAdapterAbstract
import org.uqbar.arena.widgets.Selector
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import persistencia.HomeIngrediente

abstract class EditarIngredienteTemplate extends TransactionalDialog<Object>{
	
	new(WindowOwner owner, Object model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		
		/** Se declara en forma de Template Metod para hacer la extension mas comoda */
		
		this.initHead(mainPanel)
		this.armarTablaDeIngredientes(mainPanel)
		this.initBottom(mainPanel)
	}
	
	def void initHead(Panel mainPanel)
	
	def void initBottom(Panel mainPanel)
 
 
 	/** Se pide al repositorio de ingredientes los ingredientes disponibles y por cada uno 
 	 *  se crea una checkbox con selector */
	def armarTablaDeIngredientes(Panel mainPanel) {
		var tablaDeIngredientes = new Panel(mainPanel)
		tablaDeIngredientes.layout= new VerticalLayout
		var	listaDeIngredientes= HomeIngrediente.instance.ingredientesDisponibles
		
		
		for (Ingrediente unIngrediente: listaDeIngredientes ) {
			this.createCheckBoxLabeledSeleccionable(tablaDeIngredientes, unIngrediente)
		}
		
	}
	
	/** La checkbox con selector va a estar asociada a un ingrediente y a la distrubcion que este tiene en la pizza  */
	
	def createCheckBoxLabeledSeleccionable(Panel tablaDeIngredientes,Ingrediente unIngrediente){
		
		/** Como no se puede tocar el dominio,
		 *  Se pide que se instancie un adapter que luego se agrega al modelo, y una vez aceptado el dialogo, el modelo
		 *  se encarga de fijarse si debe guardar el ingrediente o no.
		 */
		 
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