package prueba

import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.NotNullObservable
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
import pedido.Plato
import pizza.Ingrediente

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class PruebaTablaIng extends TransactionalDialog<PlatoPruebaAppModel>{
	
	new(WindowOwner owner, Plato model) {
		super(owner, new PlatoPruebaAppModel(model))
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = "Ingredientes Extras"
		var panelPrincipal	= new Panel(mainPanel)
		panelPrincipal.layout = new VerticalLayout
		
		this.panelIngredientesEnPizza(panelPrincipal)
		this.panelIngredientesExtrasDisponibles(panelPrincipal)
		this.panelIngredientesElegidos(panelPrincipal)
	
		new Label(panelPrincipal).text = "Costo Total"
		new Label(panelPrincipal).bindValueToProperty("precio")
	}
	

	protected def panelIngredientesEnPizza(Panel panelPrincipal) 
	{
		var panelIngredientesPizza		= new Panel(panelPrincipal)
		panelIngredientesPizza.layout 	= new VerticalLayout
		
		new Label(panelIngredientesPizza).text = "Ingredientes de la Pizza"
		new List(panelIngredientesPizza)=> 	[
												bindEnabledToProperty("tieneIngredientes")
												(items <=> "ingredientesPizzaItems").adaptWith(Ingrediente,"nombre")
											]
	}
	
	protected def panelIngredientesExtrasDisponibles(Panel panelPrincipal) 
	{
		var panelIngredientesExtras		= new Panel(panelPrincipal)
		panelIngredientesExtras.layout 	= new HorizontalLayout
		
		this.panelLabelYListaIngredientesExtrasDisponibles(panelIngredientesExtras)
		
		this.botonYSelectorIngredientesExtra(panelIngredientesExtras)
	}
	
	protected def panelLabelYListaIngredientesExtrasDisponibles(Panel panelIngredientesExtras) 
	{
		var panelLabelYListaIngExtras	= new Panel(panelIngredientesExtras)
		panelLabelYListaIngExtras.layout 	= new VerticalLayout
		
		new Label(panelLabelYListaIngExtras).text = "Ingredientes Extras Disponibles"
		new List(panelLabelYListaIngExtras)	=> 	[
													(items <=> "ingredientesExtrasItems").adaptWith(Ingrediente,"nombre")
													value <=> "ingredienteExtraSelect"
												]
	}
	
	protected def botonYSelectorIngredientesExtra(Panel panelIngredientesExtras) 
	{
		var panelBotones	= new Panel(panelIngredientesExtras)
		panelBotones.layout = new VerticalLayout
		
		val distirbucionSeleccionado	= new NotNullObservable("ingredienteExtraSelect")
		//new Label(panelBotones).text 	= "Distribucion Deseada"
		new Selector(panelBotones) => 	[
											bindEnabled(distirbucionSeleccionado)
											items <=> "distribucionesItems"
											value <=> "distribucionSelect"
										]
								
		new Button(panelBotones) =>	[
										bindEnabledToProperty("puedeAgregar")
										caption = "Agregar"
										onClick[modelObject.agregarIngredienteExtraSeleccionado()]
									]
	}
	
	protected def panelIngredientesElegidos(Panel panelPrincipal) 
	{
		var panelIngredientesElegidos	= new Panel(panelPrincipal)
		panelIngredientesElegidos.layout= new HorizontalLayout
		
		this.panelLabelYTablaIngredientesElegidos(panelIngredientesElegidos)
		this.panelBotonesYSelectorIngredientesElegidos(panelIngredientesElegidos)
	}
	
	protected def panelLabelYTablaIngredientesElegidos(Panel panelIngredientesElegidos) 
	{
		var panelLabelYTabla	= new Panel(panelIngredientesElegidos)
		panelLabelYTabla.layout	= new VerticalLayout
		
		new Label(panelLabelYTabla).text 	= "Ingredientes Extras Seleccionados"
		var tablaIngredientesExtrasElegidos	= new Table(panelLabelYTabla, typeof(PairAdapterIngredientePizza))
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
	
	protected def panelBotonesYSelectorIngredientesElegidos(Panel panelIngredientesElegidos) 
	{
		var panelSelectorYBotones	= new Panel(panelIngredientesElegidos)
		panelSelectorYBotones.layout= new VerticalLayout
		
		val ingredienteSeleccionado	= new NotNullObservable("ingredienteElegidoSelect")								
		new Button(panelSelectorYBotones) =>[
												bindEnabled(ingredienteSeleccionado)
												caption = "Quitar"
												onClick[modelObject.quitarIngredienteExtraSeleccionado()]
											]
										
		//new Label(panelSelectorYBotones).text 	= "Nueva Distribucion"								
		new Selector(panelSelectorYBotones) => [
													bindEnabled(ingredienteSeleccionado)
													items <=> "distribucionesItems"
													value <=> "distribucionElegidoSelect"
												]
										
		new Button(panelSelectorYBotones) =>[
												bindEnabledToProperty("puedeModificar")
												caption = "Modificar Distribucion"
												onClick[modelObject.modificarDistribucionDeIngredienteExtraSeleccionado()]
											]
	}
	
}