package plato

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

import org.uqbar.arena.widgets.Panel


import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.widgets.Button
import pizza.Pizza
import pizza.Tamanio
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.EditarPedidoWindow
import pedido.EditarIngredienteTemplate
import pizza.Ingrediente
import agregarPizza.IngredienteAdapter
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.RadioSelector

@Accessors
class EditarPlatoWindow extends EditarIngredienteTemplate {
	
	protected EditarPedidoWindow mainWindow
	protected PlatoAdapter unPlatoAdapter
	
	new(EditarPedidoWindow  owner, PlatoAdapter model) {
		super(owner, model)
		mainWindow = owner
		unPlatoAdapter=model 
	}



	def selectorPizza(Panel mainPanel) {

		var panelPizza = new Panel(mainPanel)
		panelPizza.layout = new HorizontalLayout()

		new Label(panelPizza).text = "Pizza"
		val selectorNotNull = new NotNullObservable("pizzaSelect")

		new Selector<PlatoAdapter>(panelPizza) => [
			allowNull(false)
			(items <=> "pizzaItems").adaptWith(typeof(Pizza), "nombre")
			value <=> "pizzaSelect"

			bindEnabled(selectorNotNull)
		]
	}

	def selectorSizePizza(Panel mainPanel) {
		var panelSize = new Panel(mainPanel)
		panelSize.layout = new HorizontalLayout()
		
		new Label(panelSize).text = "Medida"
		val selectorNotNull = new NotNullObservable("sizeSelect")

		new Selector<PlatoAdapter>(panelSize) => [
			allowNull(false)
			(items <=> "itemsSize").adaptWith(typeof(Tamanio), "nombre")
			value <=> "sizeSelect"

			bindEnabled(selectorNotNull)
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

	def footButton(Panel mainPanel) {
		var panelButton = new Panel(mainPanel)
		panelButton.layout = new HorizontalLayout()
		
		new Button(panelButton) => [
			caption = "Aceptar"
			onClick [
				unPlatoAdapter.plato.pizza = unPlatoAdapter.pizzaSelect
				unPlatoAdapter.plato.tamanio = unPlatoAdapter.sizeSelect
				
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
	
	override defaultTitle() {
		"Plato"
	}
	
	override initHead(Panel mainPanel) {
		selectorPizza(mainPanel)
		selectorSizePizza(mainPanel)
	}
	
	override initBottom(Panel mainPanel) {
		footLabel(mainPanel)
		footButton(mainPanel)
	}
	
	override getAdapter(Ingrediente unIngrediente) {
		new IngredienteAdapterParaPlato(unIngrediente, unPlatoAdapter)
	}
	
	
}
