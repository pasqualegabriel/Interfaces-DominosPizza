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

import pedido.Plato
import org.uqbar.arena.aop.windows.TransactionalDialog
import pedido.PedidoWindowEditar
import org.uqbar.arena.layout.VerticalLayout

@Accessors
class EditarPlatoWindow extends TransactionalDialog<PlatoAppModel> {
	
	protected PedidoWindowEditar mainWindow
	protected Plato unPlato
	
	new(PedidoWindowEditar  owner, Plato model) {
		super(owner, new PlatoAppModel(model))
		mainWindow = owner
		unPlato=model 
	}
	
	override protected createFormPanel(Panel mainPanel) {
		title = "Plato"
		mainPanel.layout = new VerticalLayout
		selectorPizza(mainPanel)
		selectorSizePizza(mainPanel)
		footLabel(mainPanel)
		footButton(mainPanel)
		
	}


	def selectorPizza(Panel mainPanel) {

		var panelPizza = new Panel(mainPanel)
		panelPizza.layout = new HorizontalLayout()

		new Label(panelPizza).text = "Pizza"
		val selectorNotNull = new NotNullObservable("pizzaSelect")

		new Selector<PlatoAppModel>(panelPizza) => [
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

		new Selector<PlatoAppModel>(panelSize) => [
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
				mainWindow.modelObject.setPrecio
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
	
	
	
}
