package menuPizzas

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import pizza.Pizza
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.NotNullObservable

class PanelDePromos extends PanelConListaEditable 
{
	MenuDeDominoMainWindow mainWindow

	new(Container container, MenuDeDominoMainWindow aMainWindow) 
	{
		super(container)
		mainWindow = aMainWindow
	}

	/**Metodo que se encarga de definir el Label "Promociones" */
	override initLabel(Panel aPanel) 
	{
		var aLabel = new Label(aPanel).text = "Promociones"
		aLabel.alignLeft
	}

	/**Metodo que define la tabla que contiene a las promociones disponibles */
	override initList(Panel aPanel) 
	{
		val tablaDePizzas = new Table<Pizza>(aPanel, typeof(Pizza)) => 
									[
										items <=> "promosDisponibles"
										value <=> "pizzaSeleccionada"
									]
									
		new Column(tablaDePizzas) => 
				[
					title = "Nombre"
					fixedSize = 200
					bindContentsToProperty("nombre")
				]
				
		new Column(tablaDePizzas) => 
				[
					title = "Precio"
					fixedSize = 200
					bindContentsToProperty("precioBase").transformer = [ precio | '''$ «precio»''']
					//transforma el precio de una pizza para que se muestre con el signo $
				]
	}

	/**Define el boton para crear una pizza */
	override initCreateButton(Panel aPanel) 
	{
		new Button(aPanel) => 
			[
				caption = "Crear"
				onClick [	mainWindow.crearPizza	]
			]
	}

	/**Define el boton para editar una pizza */
	override initEditButton(Panel aPanel) 
	{
		val habilitadorDeSeleccion = new NotNullObservable("pizzaSeleccionada")
		new Button(aPanel) => [
			caption = "Edit"
			onClick [	mainWindow.editarPizza	]
			bindEnabled(habilitadorDeSeleccion)	//Solo se habilita el boton si hay una pizza seleccionada
		]
	}

	/**Define el boton para borrar una pizza */
	override initDeleteButton(Panel aPanel) 
	{
		val habilitadorDeSeleccion = new NotNullObservable("pizzaSeleccionada")
		new Button(aPanel) => 
			[
				caption = "Delete"
				onClick [	mainWindow.eliminarPizza	]
				bindEnabled(habilitadorDeSeleccion) //Solo se habilita el boton si hay una pizza seleccionada
			]
	}

}
