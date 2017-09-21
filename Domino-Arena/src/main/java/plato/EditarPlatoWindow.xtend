package plato

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

import org.uqbar.arena.widgets.Panel


import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.Button
import pizza.Pizza
import pizza.Tamanio
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.PedidoWindowEditar
import pedido.EditarIngredienteTemplate
import agregarPizza.IngredienteAdapterAbstract
import pizza.Ingrediente

@Accessors
class EditarPlatoWindow extends EditarIngredienteTemplate {
	
	protected PedidoWindowEditar mainWindow
	protected PlatoAppModel unPlato
	
	new(PedidoWindowEditar  owner, PlatoAppModel unModel) {
		super(owner, unModel)
		mainWindow = owner
		unPlato= unModel 
	}
	


	def selectorPizza(Panel mainPanel) {

		var panelPizza = new Panel(mainPanel)
		panelPizza.layout = new HorizontalLayout()

		new Label(panelPizza).text = "Pizza"

		new Selector<PlatoAppModel>(panelPizza) => [
			allowNull(false)
			(items <=> "pizzaItems").adaptWith(typeof(Pizza), "nombre")
			value <=> "pizzaSelect"

		]
	}

	def selectorSizePizza(Panel mainPanel) {
		var panelSize = new Panel(mainPanel)
		panelSize.layout = new HorizontalLayout()
		
		new Label(panelSize).text = "Medida"

		new Selector<PlatoAppModel>(panelSize) => [
			allowNull(false)
			(items <=> "itemsSize").adaptWith(typeof(Tamanio), "nombre")
			value <=> "sizeSelect"

		]

	}

	def footButton(Panel mainPanel) {
		var panelButton = new Panel(mainPanel)
		panelButton.layout = new HorizontalLayout()
		new Button(panelButton) => [
			caption = "Aceptar"
			onClick [
				this.accept
				setAsDefault
				disableOnError
			]
			
		]

		new Button(panelButton) => [
			caption = "Cancelar"
			onClick [
				close
			]
		]
	}
	


	
	override initHead(Panel mainPanel) {
		selectorPizza(mainPanel)
		selectorSizePizza(mainPanel)
	}
	
	override initBottom(Panel mainPanel) {
		footButtonCalculate(mainPanel)
		footLabel(mainPanel)
		footButton(mainPanel)
	}
	
	def footButtonCalculate(Panel mainPanel) {
		var panelButton 	= new Panel(mainPanel)
		panelButton.layout 	= new HorizontalLayout()
		
		new Button(panelButton) => [
			caption = "Calcular Precio"
			onClick [
				
				unPlato.calcularPrecio
				setAsDefault
				disableOnError
			]
			
		]
	
	
	}
	
	def footLabel(Panel mainPanel) {
		var panelLabel = new Panel(mainPanel)
		panelLabel.layout = new HorizontalLayout()

		new Label(panelLabel).text = "Precio"
		new Label(panelLabel) => [
			
			value <=> "precio"
		]

	}
	
	
	override agregarAModelo(IngredienteAdapterAbstract ingredienteAdapter) {
			unPlato.ingredientesExtras.add(ingredienteAdapter)
	}
	
	override getAdapter(Ingrediente unIngrediente) {
		  new IngredienteExtraAppModel(unPlato,unIngrediente)
	}
	
	override accept() {
		super.accept
		unPlato.aceptarCambio
		mainWindow.modelObject.calcularPrecio
		
	}
	
}
