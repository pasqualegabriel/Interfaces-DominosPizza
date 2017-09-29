package edicionDePromocion

import menuPizzas.MenuDeDominoMainWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import pizza.Ingrediente
import org.uqbar.arena.widgets.Button

import org.eclipse.xtend.lib.annotations.Accessors
import plato.EditarIngredienteTemplate
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class EditarPromocionWindow extends EditarIngredienteTemplate {

	protected MenuDeDominoMainWindow mainWindow
	protected PromoAppModel modelo

	new(MenuDeDominoMainWindow aMainWindow, PromoAppModel unaPizza) {

		super(aMainWindow, unaPizza)
		modelo = unaPizza
		mainWindow = aMainWindow
		this.title = "Editar Promocion"
	}

	override initHead(Panel mainPanel) {
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

	override getAdapter(Ingrediente unIngrediente) {
		new IngredienteAdapter(unIngrediente, modelo.pizza)
	}

	override initBottom(Panel mainPanel) {
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

	override void agregarAModelo(IngredienteAdapterAbstract unIngredienteAdapter) {
		modelo.ingredientes.add(unIngredienteAdapter)
	}

	def alternativeTitle() {
		this.title = "Crear Promocion"
	}

	override accept() {
			modelo.aceptarCambios
			super.accept
	}

}
