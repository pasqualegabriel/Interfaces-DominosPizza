package pedido

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.TextBox
import estados.EstadoDePedido
import plato.EditarPlatoWindow
import plato.AgregarPlatoWindow
import plato.PlatoAppModel


class PedidoWindowEditar extends TransactionalDialog<PedidoAppModel> {
	
	
	new(WindowOwner owner, Pedido pedido) {
		super(owner, new PedidoAppModel(pedido))
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = this.titulo

		mainPanel.layout = new VerticalLayout()

		labelYSelectorEstado(mainPanel)
		tablaPlato(mainPanel)
		aclaracionesPlatos(mainPanel)
		datosPlatos(mainPanel)
		ultimosBotonesPlatos(mainPanel)
	}
	
	def titulo() 
	{	'''Editar Pedido de «modelObject.pedidoAdaptado.miembro.nombre»'''.toString	}

	def labelYSelectorEstado(Panel mainPanel) {

		var panelEstados = new Panel(mainPanel)
		panelEstados.layout = new HorizontalLayout

		new Label(panelEstados).text = "Estado: "
		selectorDeEstado(panelEstados)
	}
	
	def void selectorDeEstado(Panel panelEstados) 
	{
		new Selector<EstadoDePedido>(panelEstados) => 
				[
					(items <=> "estadosSelector").adaptWith(typeof(EstadoDePedido), "nombre")
					value <=> "cambioDeEstado"
					onAccept(execute(modelObject,"cambiarAEstadoSeleccionado") )
				]
	}
	
	
	/**Crea toda la estructura de la tabla para platos */
	def tablaPlato(Panel mainPanel) {

		var panelPlatos = new Panel(mainPanel)
		panelPlatos.layout = new ColumnLayout(2)
		tabla(panelPlatos)
		botonesPlatos(panelPlatos)
	}
	/**Crea una tabla de platos */
	def tabla(Panel panelPlatos) {
		var panelTablaPlatos = new Panel(panelPlatos)
		panelTablaPlatos.layout = new VerticalLayout

		new Label(panelTablaPlatos).text = "Platos"

		val tablaPedidos = new Table(panelTablaPlatos, typeof(Plato)) => [
			//bindEnabledToProperty("noEstaCerrado")
			numberVisibleRows = 6
			items <=> "itemsPlatos"
			value <=> "platoSeleccionado"
		]

		columnasDePlato(tablaPedidos,"Nombre","pizza.nombre")
		columnasDePlato(tablaPedidos,"Tamaño","tamanio.nombre")
		columnasDePlatoPrecio(tablaPedidos)


	}
	/**Crea las columnas del plato */
	def columnasDePlato(Table<Plato> tablaPedidos,String titulo,String value){
		new Column(tablaPedidos) => [
			title = titulo
			bindContentsToProperty(value)
		]
	}
	/**Crea la columna especifica de precio del plato*/
	def columnasDePlatoPrecio(Table<Plato> tablaPedidos){
		new Column(tablaPedidos) => [
			title = "Precio"
			bindContentsToProperty("calcularPrecio").transformer = [precio | '''$ «precio»''']
		]
	}
	
	/**Crea los botones que van a utilizar la tabla de plato  */
	def botonesPlatos(Panel panelPlatos) {
		var panelBotonesPlatos = new Panel(panelPlatos)
		panelBotonesPlatos.layout = new VerticalLayout
		
		new Button(panelBotonesPlatos) => [
			bindVisibleToProperty("noEstaCerrado")
			caption = "Agregar"
			onClick [
						new AgregarPlatoWindow(this).open
					]
		]

		new Button(panelBotonesPlatos) => [
			caption = "Editar"
			setAsDefault
			onClick [
				new EditarPlatoWindow(this, new PlatoAppModel(modelObject.platoSeleccionado)).open
			]
			bindEnabledToProperty("sePuedeEditar")
			bindVisibleToProperty("noEstaCerrado")
			
		]

		new Button(panelBotonesPlatos) => [
			bindVisibleToProperty("noEstaCerrado")
			caption = "Eliminar"
			onClick [
				modelObject.eliminarPlato
				modelObject.calcularPrecio
			]
			bindEnabledToProperty("sePuedeEditar")
		]
		
	}

	def aclaracionesPlatos(Panel mainPanel) {

		new Label(mainPanel).text = "Aclaraciones:"

		aclaracion(mainPanel)
	}
	
	def void aclaracion(Panel mainPanel) 
	{
		new TextBox(mainPanel) => 
				[
					width    = 20
					fontSize = 9
					value   <=> "pedidoAdaptado.aclaracion"
				]
	}

	def void datosPlatos(Panel mainPanel) 
	{
		var panelDatosPlatos = new Panel(mainPanel)
		panelDatosPlatos.layout = new ColumnLayout(2)

		new Label(panelDatosPlatos).text = "Cliente"

		new Label(panelDatosPlatos).value <=> "pedidoAdaptado.miembro.nombre"

		new Label(panelDatosPlatos).text = "Costo de envío"

		new Label(panelDatosPlatos).value <=> "costoDeEnvio"  

		new Label(panelDatosPlatos).text = "Monto total"
	
		new Label(panelDatosPlatos).value <=> "precioMostrable"

		new Label(panelDatosPlatos).text = "Hora"

		new Label(panelDatosPlatos).value <=> "hora"
	}

	def ultimosBotonesPlatos(Panel mainPanel) {

		var panelUltimosBotonesPlatos = new Panel(mainPanel)
		panelUltimosBotonesPlatos.layout = new HorizontalLayout

		new Button(panelUltimosBotonesPlatos) => [
			caption = "Aceptar"
			onClick [
						modelObject.aceptarCambios
						accept
						disableOnError
					]
		]

		new Button(panelUltimosBotonesPlatos) => 
			[
				bindVisibleToProperty("noEstaCerrado")
				caption = "Cancelar"
				onClick [	
					close
				]
			]
	}

}
