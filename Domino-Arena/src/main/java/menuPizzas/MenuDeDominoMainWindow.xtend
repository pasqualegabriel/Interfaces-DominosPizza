package menuPizzas

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button

import agregarIngrediente.EditarIngredientesWindow

import agregarPizza.PromoAppModel
import pizza.Ingrediente
import pizza.Pizza
import pizza.Distribucion
import org.uqbar.commons.model.exceptions.UserException
import agregarPizza.EditarPromocionWindow

class MenuDeDominoMainWindow  extends SimpleWindow<MenuDeDominoAppModel>{
	
	
	new(WindowOwner parent, MenuDeDominoAppModel unModel) {
		super(parent, unModel)
	}
	
	override protected addActions(Panel actionsPanel) {
		//parte del template method no usada
	}
	
	override protected createFormPanel(Panel mainPanel) {
		//parte del template method no usada
	}
	
	// esta es el panel principal
	override createMainTemplate(Panel mainPanel) {
		// le ponemos el titulo
		this.title = "MenuDomino"
		// decimos que su layout va a ser vertical
		mainPanel.layout = new VerticalLayout
		

		//Agregamos el contenido a nuestro panel que van a ser 2 paneles mas!
		// Como ambos paneles son casi identicos, creamos una clase abstracta que define un template method
		// y los dos paneles que necesitamos lo redefinen a su manera
		new PanelDePromos(mainPanel, this)
		new PanelDeIngredientes(mainPanel,this)
		// agregamos el boton para cerrar todo
		new Button(mainPanel) => [

			caption = "cerrar"
			onClick [ | this.close]
			]
	
	}
	
	def crearIngrediente() {
		val	dialog = new EditarIngredientesWindow(this, new Ingrediente("",0.00))
		dialog.alternativeTitle
		dialog.onAccept[this.modelObject.agregarIngrediente(dialog.modelObject)]
		dialog.open
		
	}
	
	def editarIngrediente() {
		val	dialog = new EditarIngredientesWindow(this, modelObject.ingredienteSeleccionado)
		dialog.onAccept[this.modelObject.actualizarIngredientesDisponibles]
		dialog.open
		
	}
	
	def eliminarIngrediente() {
		if(modelObject.ingredientesDisponibles.size > 1){
			modelObject.eliminarIngrediente(modelObject.ingredienteSeleccionado)
		}
		else {
			throw new UserException("No se puede eliminar el ultimo ingrediente")
		}
	}

	def crearPizza() {
		val	dialog = new EditarPromocionWindow(this, new PromoAppModel(new Pizza("",0.00,new Distribucion)))
		dialog.alternativeTitle
		dialog.open
	}

	
	def editarPizza() {
		var editorDePizzas = new EditarPromocionWindow(this, new PromoAppModel(modelObject.pizzaSeleccionada))
		editorDePizzas.open
	}
	
	def eliminarPizza() {
		if(modelObject.promosDisponibles.size > 1){
			modelObject.eliminarPizza(modelObject.pizzaSeleccionada)
		}
		else {
			throw new UserException("No se puede eliminar la ultima promocion")
		}
	}
	
}