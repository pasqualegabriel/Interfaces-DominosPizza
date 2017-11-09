package plato

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import pizza.Ingrediente
import pizza.Pizza
import pizza.Tamanio

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import pedido.PrecioTransformer
import pedido.Plato
import pizza.PairIngredienteDistribucionPizza
import arenaAppModels.PlatoAppModel

class PlatoWindow extends TransactionalDialog<PlatoAppModel>{
	
	new(WindowOwner owner, Plato model) {
		super(owner, new PlatoAppModel(model))
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		
		title = '''«this.titulo» Plato'''
		var panelPrincipal	= new Panel(mainPanel)
		panelPrincipal.layout = new VerticalLayout
		
		this.selectorPizza(panelPrincipal)
		this.selectorSizePizza(panelPrincipal)
		this.panelIngredientesEnPizza(panelPrincipal)
		this.panelIngredientesExtrasDisponibles(panelPrincipal)
		this.panelIngredientesElegidos(panelPrincipal)
		this.panelPrecioPlato(panelPrincipal)
		this.panelBotones(panelPrincipal)
	}
	
	def titulo() 
	{
		"Editar"
	}
		
	private def selectorPizza(Panel mainPanel) 
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
	private def selectorSizePizza(Panel mainPanel) 
	{
		var panelSize = new Panel(mainPanel)
		panelSize.layout = new HorizontalLayout()
		
		new Label(panelSize).text = "Tamaño"

		new Selector<PlatoAppModel>(panelSize) => 
		[
			allowNull(false)
			(items <=> "itemsSize").adaptWith(typeof(Tamanio), "nombre") //El adapter hace que se muestre el tamaño por el nombre
			value <=> "sizeSelect"
		]

	}

	private def panelIngredientesEnPizza(Panel panelPrincipal) 
	{
		var panelIngredientesPizza		= new Panel(panelPrincipal)
		panelIngredientesPizza.layout 	= new VerticalLayout
		
		new Label(panelIngredientesPizza).text = "Ingredientes de la Pizza"
		new List(panelIngredientesPizza)=> 	[
												bindEnabledToProperty("tieneIngredientes")
												(items <=> "ingredientesPizzaItems").adaptWith(Ingrediente,"nombre")
											]
	}
	
	private def panelIngredientesExtrasDisponibles(Panel panelPrincipal) 
	{
		var panelIngredientesExtras		= new Panel(panelPrincipal)
		panelIngredientesExtras.layout 	= new HorizontalLayout
		
		this.panelLabelYListaIngredientesExtrasDisponibles(panelIngredientesExtras)
		
		this.botonYSelectorIngredientesExtra(panelIngredientesExtras)
	}
	
	private def panelLabelYListaIngredientesExtrasDisponibles(Panel panelIngredientesExtras) 
	{
		var panelLabelYListaIngExtras		= new Panel(panelIngredientesExtras)
		panelLabelYListaIngExtras.layout 	= new VerticalLayout
		
		new Label(panelLabelYListaIngExtras).text = "Ingredientes Extras Disponibles"
		new List(panelLabelYListaIngExtras)	=> 	[
													(items <=> "ingredientesExtrasItems").adaptWith(Ingrediente,"nombre")
													value <=> "ingredienteExtraSelect"
												]
	}
	
	private def botonYSelectorIngredientesExtra(Panel panelIngredientesExtras) 
	{
		var panelBotones	= new Panel(panelIngredientesExtras)
		panelBotones.layout = new VerticalLayout
		
		new Label(panelBotones).text 	= "Distribucion Deseada"
		new Selector(panelBotones) => 	[
											bindEnabledToProperty("hayIngredienteExtra")
											items <=> "distribucionesItems"
											value <=> "distribucionSelect"
										]
								
		new Button(panelBotones) =>	[
										bindEnabledToProperty("puedeAgregar")
										caption = "Agregar"
										onClick[modelObject.agregarIngredienteExtraSeleccionado()]
									]
	}
	
	private def panelIngredientesElegidos(Panel panelPrincipal) 
	{
		var panelIngredientesElegidos	= new Panel(panelPrincipal)
		panelIngredientesElegidos.layout= new HorizontalLayout
		
		this.panelLabelYTablaIngredientesElegidos(panelIngredientesElegidos)
		this.panelBotonesYSelectorIngredientesElegidos(panelIngredientesElegidos)
	}
	
	private def panelLabelYTablaIngredientesElegidos(Panel panelIngredientesElegidos) 
	{
		var panelLabelYTabla	= new Panel(panelIngredientesElegidos)
		panelLabelYTabla.layout	= new VerticalLayout
		
		new Label(panelLabelYTabla).text 	= "Ingredientes Extras Seleccionados"
		var tablaIngredientesExtrasElegidos	= new Table(panelLabelYTabla, typeof(PairIngredienteDistribucionPizza))
		tablaIngredientesExtrasElegidos => 	[
											numberVisibleRows = 2
											items <=> "ingredientesElegidosItems"
											value <=> "ingredienteElegidoSelect"
											]
											
		new Column(tablaIngredientesExtrasElegidos) => [
															title = "Ingrediente"
															bindContentsToProperty("ingrediente").transformer = [Ingrediente i | i.nombre]
														]
														
		new Column(tablaIngredientesExtrasElegidos) => [
															title = "Distribucion"
															bindContentsToProperty("distribucion")
														]
	}
	
	private def panelBotonesYSelectorIngredientesElegidos(Panel panelIngredientesElegidos) 
	{
		var panelSelectorYBotones	= new Panel(panelIngredientesElegidos)
		panelSelectorYBotones.layout= new VerticalLayout
										
		new Button(panelSelectorYBotones) =>[
												bindEnabledToProperty("hayIngredienteElegido")
												caption = "Quitar"
												onClick[modelObject.quitarIngredienteExtraSeleccionado()]
											]
										
		new Label(panelSelectorYBotones).text 	= "Nueva Distribucion"								
		new Selector(panelSelectorYBotones) => [
													bindEnabledToProperty("hayIngredienteElegido")
													items <=> "distribucionesItems"
													value <=> "distribucionElegidoSelect"
													
												]
										
		new Button(panelSelectorYBotones) =>[
												bindEnabledToProperty("puedeModificar")
												caption = "Modificar Distribucion"
												onClick[modelObject.modificarDistribucionDeIngredienteExtraSeleccionado()]
											]
	}
	
	private def panelPrecioPlato(Panel panelPrincipal) 
	{
		var panelPrecio		= new Panel(panelPrincipal)
		panelPrecio.layout 	= new HorizontalLayout
		
		new Label(panelPrecio).text = "Costo Total: "
		new Label(panelPrecio).bindValueToProperty("precio").transformer = new PrecioTransformer
	}

	/**Define los botones inferiores de aceptar y cancelar*/
	private def panelBotones(Panel panelPrincipal) 
	{
		var panelBotones = new Panel(panelPrincipal)
		panelBotones.layout = new HorizontalLayout()
		new Button(panelBotones) => 
					[
						caption = "Aceptar"
						onClick 
						[
							this.accept
							this.modelObject.aceptarCambios
							disableOnError
						]
						
					]

		new Button(panelBotones) => 
					[
						caption = "Cancelar"
						onClick [	close	]
					]
	}
}
