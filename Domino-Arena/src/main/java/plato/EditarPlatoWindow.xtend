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
class EditarPlatoWindow extends EditarIngredienteTemplate 
{
	protected PedidoWindowEditar mainWindow
	protected PlatoAppModel unPlato
	
	new(PedidoWindowEditar  owner, PlatoAppModel unModel) 
	{
		super(owner, unModel)
		mainWindow = owner
		unPlato= unModel 
	}
	

	/**Define el selector de promociones de pizza */
	def selectorPizza(Panel mainPanel) 
	{
		var panelPizza = new Panel(mainPanel)
		panelPizza.layout = new HorizontalLayout()

		new Label(panelPizza).text = "Pizza"

		new Selector<PlatoAppModel>(panelPizza) => 
					[
						allowNull(false)
						(items <=> "pizzaItems").adaptWith(typeof(Pizza), "nombre") //El adapter hace que se muestre la pizza por el nombre
						value <=> "pizzaSelect"
					]
	}

	/**Define el selector de tamaño de pizza */
	def selectorSizePizza(Panel mainPanel) 
	{
		var panelSize = new Panel(mainPanel)
		panelSize.layout = new HorizontalLayout()
		
		new Label(panelSize).text = "Medida"

		new Selector<PlatoAppModel>(panelSize) => 
		[
			allowNull(false)
			(items <=> "itemsSize").adaptWith(typeof(Tamanio), "nombre") //El adapter hace que se muestre el tamaño por el nombre
			value <=> "sizeSelect"
		]

	}

	/**Define los botones inferiores de aceptar y cancelar*/
	def footButton(Panel mainPanel) 
	{
		var panelButton = new Panel(mainPanel)
		panelButton.layout = new HorizontalLayout()
		new Button(panelButton) => 
					[
						caption = "Aceptar"
						onClick 
						[
							this.accept
							setAsDefault
							disableOnError
						]
						
					]

		new Button(panelButton) => 
					[
						caption = "Cancelar"
						onClick [	close	]
					]
	}

	/**Metodo donde se llaman los metodos de donde se definen los selectores de pizza y tamaño*/
	override initHead(Panel mainPanel) 
	{
		selectorPizza(mainPanel)
		selectorSizePizza(mainPanel)
	}
	
	/**Define los botones de calcular precio, el label de precio y los botones inferiores(Aceptar y cancelar)*/
	override initBottom(Panel mainPanel) 
	{
		footButtonCalculate(mainPanel)
		footLabel(mainPanel)
		footButton(mainPanel)
	}
	
	/**Define el boton de calculo de precio del Plato */
	def footButtonCalculate(Panel mainPanel) 
	{
		var panelButton 	= new Panel(mainPanel)
		panelButton.layout 	= new HorizontalLayout()
		
		new Button(panelButton) => 
					[
						caption = "Calcular Precio"
						onClick [
									unPlato.calcularPrecio
									setAsDefault
									disableOnError
								]
					]
	}
	
	/**Define el label donde se meustra el precio del plato*/
	def footLabel(Panel mainPanel) 
	{
		var panelLabel = new Panel(mainPanel)
		panelLabel.layout = new HorizontalLayout()

		new Label(panelLabel).text = "Precio"
		new Label(panelLabel) => [	value <=> "precio"	]
	}
	
	/**Redefine el metodo y para agregar al medole un ingrediente adapter */
	override agregarAModelo(IngredienteAdapterAbstract ingredienteAdapter) 
	{	unPlato.ingredientesExtras.add(ingredienteAdapter)	}
	
	/**Redefine el metodo y para agregar al medole un ingrediente adapter */
	override getAdapter(Ingrediente unIngrediente) 
	{	new IngredienteExtraAppModel(unPlato,unIngrediente)	}
	
	/**Redefine el metodo y para realizar los cambios necesarios al momento de de aceptar en la ventana*/
	override accept() 
	{
		super.accept
		unPlato.aceptarCambio
		mainWindow.modelObject.calcularPrecio
	}
	
}
