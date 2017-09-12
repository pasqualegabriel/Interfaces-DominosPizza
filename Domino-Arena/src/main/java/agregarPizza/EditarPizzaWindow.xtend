package agregarPizza

import menuPizzas.MenuDeDominoMainWindow
import org.uqbar.arena.aop.windows.TransactionalDialog
import pizza.Pizza
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import pizza.Ingrediente
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.RadioSelector
import org.uqbar.arena.widgets.Button

class EditarPizzaWindow extends TransactionalDialog<Pizza>{
	
	protected MenuDeDominoMainWindow mainWindow
	
	new(MenuDeDominoMainWindow aMainWindow, Pizza unaPizza) {
		
		super(aMainWindow, unaPizza)
		mainWindow = aMainWindow
	}
	
	override protected createFormPanel(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
		this.title = this.defaultTitle
		
		// Se declara en forma de Template Metod para hacer la extension mas comoda
		
		this.initHead(mainPanel)
		this.armarTablaDeIngredientes(mainPanel)
		this.initBottom(mainPanel)
	
	}
	
	
	
	def initHead(Panel mainPanel) {
		new Label(mainPanel).text = "Nombre"
		new TextBox(mainPanel) => [
			value <=> "nombre"
			width = 100
		]
		
		new Label(mainPanel).text = "Precio"
		new TextBox(mainPanel) => [
			value <=> "precioBase"
			width = 100
		]
	}
	
// Los problemas empiezan por culpa de esto. Vos necesitas una Checkbox con selector
// Por cada uno de los ingredientes que haya disponible. No hay otra forma que hacerlo que con un for
// Esta parte no me parece que este mal, la parte que me parece mal es la de createCheckBox

	def armarTablaDeIngredientes(Panel mainPanel) {
		var tablaDeIngredientes = new Panel(mainPanel)
		tablaDeIngredientes.layout= new VerticalLayout
		var	listaDeIngredientes= mainWindow.modelObject.ingredientesDisponibles
		
		
		for (Ingrediente unIngrediente: listaDeIngredientes ) {
			this.createCheckBoxLabeledSeleccionable(tablaDeIngredientes, unIngrediente)
		}
		
	}
	
// Esto hay que preguntarlo o rehacerlo. El problema mas grave de todos es que segun dijeron los profesores
// tenes que tener un solo modelo por ventana. Pero aca cada checkbox opera con su propio modelo
// No pude encontrar otra manera de hacerlo por la naturaleza del checkbox, necesita contraponerse contra
// algo que de un bool, y no encontre como hacerlo funcionar contra un map tampoco.

// Otro problema es que al parecer se pierde la transaccionalidad asi, lo cual no deberia pasar.

// El segundo problema esta en que el enabled no parece funcionar por alguna razon.
	def createCheckBoxLabeledSeleccionable(Panel panel, Ingrediente unIngrediente) {
	  	var ingredienteAppModel = new IngredienteAppModel(unIngrediente, modelObject)
      	var checkBoxDeIngrediente = new Panel(panel, ingredienteAppModel)
      	checkBoxDeIngrediente.setLayout = new HorizontalLayout
     	
      
		new CheckBox(checkBoxDeIngrediente) => [
   			value <=> "estaEnLaPizza"
		]
		
		new Label(checkBoxDeIngrediente).text= unIngrediente.nombre
		
		new RadioSelector(checkBoxDeIngrediente) => [
			// enabled <=> "estaEnLaPizza"
            items <=> "distribuciones"
            value <=> "distribucionSeleccionada"
      ]
	}
      
 
	
	def initBottom(Panel mainPanel) {
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.accept]
			
			disableOnError	
		]
		new Button(mainPanel) => [
			caption = "Cancelar"	
			onClick [|
				this.cancel
			]
		]
	}
	
	def defaultTitle() {
		"Editar Promo"
	}
	
	
}