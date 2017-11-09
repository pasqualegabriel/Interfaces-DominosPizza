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
import plato.PlatoWindow
import plato.AgregarPlatoWindow
import arenaAppModels.PedidoAppModel

/** Clase que genera la ventana de edicion de un pedido*/
class PedidoWindowEditar extends TransactionalDialog<PedidoAppModel> 
{
	new(WindowOwner owner, Pedido pedido) 
	{	super(owner, new PedidoAppModel(pedido))	}

	/**Se encarga de Crear el panel principal con el selector de estado, la tabla de pedidos, 
	 * los botones que interactuan con la tabla de pedidos, los datos del pedido y los botones que
	 * interactuan con la ventana pedido*/
	override protected createFormPanel(Panel mainPanel) 
	{
		this.title = this.titulo

		mainPanel.layout = new VerticalLayout()

		labelYSelectorEstado(mainPanel)
		tablaPlato(mainPanel)
		aclaracionesPlatos(mainPanel)
		datosPlatos(mainPanel)
		ultimosBotonesPlatos(mainPanel)
	}
	
	/** Define el titulo de la ventana*/
	def titulo() 
	{	'''Editar Pedido de «modelObject.pedidoAdaptado.miembro.nombre»'''.toString	}

	/** Define el label de estado y el selector de estados para el pedido */
	def labelYSelectorEstado(Panel mainPanel) 
	{
		var panelEstados = new Panel(mainPanel)
		panelEstados.layout = new HorizontalLayout

		new Label(panelEstados).text = "Estado: "
		selectorDeEstado(panelEstados)
	}

	/**Define el selector de estados */	
	def void selectorDeEstado(Panel panelEstados) 
	{
		new Selector<EstadoDePedido>(panelEstados) => 
				[
					(items <=> "estadosSelector").adaptWith(typeof(EstadoDePedido), "nombre") //El adapter hace que se muestre el nombre del estado
					value <=> "cambioDeEstado"
					onAccept[	this.modelObject.cambiarAEstadoSeleccionado	]
				]
	}
	
	
	/**Crea toda la estructura de la tabla para platos con los botones que interactuan en esta */
	def tablaPlato(Panel mainPanel) 
	{
		var panelPlatos = new Panel(mainPanel)
		panelPlatos.layout = new ColumnLayout(2)
		tabla(panelPlatos)
		botonesPlatos(panelPlatos)
	}
	
	/**Crea una tabla de platos */
	def tabla(Panel panelPlatos) 
	{
		var panelTablaPlatos = new Panel(panelPlatos)
		panelTablaPlatos.layout = new VerticalLayout

		new Label(panelTablaPlatos).text = "Platos"

		val tablaPedidos = new Table(panelTablaPlatos, typeof(Plato)) => 
									[
										numberVisibleRows = 6
										items <=> "itemsPlatos"
										value <=> "platoSeleccionado"
									]

		columnasDePlato(tablaPedidos,"Nombre","pizza.nombre")
		columnasDePlato(tablaPedidos,"Tamaño","tamanio.nombre")
		columnasDePlatoPrecio(tablaPedidos)
	}
	
	/**Metodo generico para crear columnas, se le pasa la tabla a la que pertenecera, el titulo y el valor que mostrara */
	def columnasDePlato(Table<Plato> tablaPedidos,String titulo,String value)
	{
		new Column(tablaPedidos) => 
			[
				title = titulo
				bindContentsToProperty(value)
			]
	}
	
	/**Crea la columna especifica de precio del plato*/
	def columnasDePlatoPrecio(Table<Plato> tablaPedidos)
	{
		new Column(tablaPedidos) => 
			[
				title = "Precio"
				bindContentsToProperty("precio").transformer = [	precio | '''$ «precio»'''	]
				//El transformer acomoda la vista del precio para mostrarlo con el signo 
			]
	}
	
	/**Crea los botones que van a utilizar la tabla de plato */
	def botonesPlatos(Panel panelPlatos) 
	{
		var panelBotonesPlatos = new Panel(panelPlatos)
		panelBotonesPlatos.layout = new VerticalLayout
		
		new Button(panelBotonesPlatos) => 
			[
				bindVisibleToProperty("noEstaCerrado")	//Si el pedido esta cerrado no se muestra el boton
				caption = "Agregar"
				onClick [	
						new AgregarPlatoWindow(this, modelObject.nuevoPlato) => 
											[	
												open
												this.modelObject.actualizar
											]
						] //Abre la ventana para agregar un nuevo plato
			]

		new Button(panelBotonesPlatos) => 
			[
				caption = "Editar"
				onClick [	
							new PlatoWindow(this, modelObject.platoSeleccionado) =>
											[
												open
												this.modelObject.actualizar
											]
						]
				bindEnabledToProperty("sePuedeEditar")	//Se habilita al haber un pedido seleccionado
				bindVisibleToProperty("noEstaCerrado")	//Si el pedido esta cerrado no se muestra el boton
			]

		new Button(panelBotonesPlatos) => 
			[
				caption = "Eliminar"
				onClick [
							modelObject.eliminarPlato
						]
				bindVisibleToProperty("noEstaCerrado")	//Si el pedido esta cerrado no se muestra el boton
				bindEnabledToProperty("sePuedeEliminar")	//Se habilita al haber un pedido seleccionado
			]
	}

	/**Metodo que crea el label y el textbox para las aclaraciones del pedido*/
	def aclaracionesPlatos(Panel mainPanel) 
	{
		new Label(mainPanel).text = "Aclaraciones:"
		aclaracion(mainPanel)
	}

	/**Crea el textbox de las aclaraciones del pedido */	
	def void aclaracion(Panel mainPanel) 
	{
		new TextBox(mainPanel) => 
				[
					width    = 20
					fontSize = 9
					value   <=> "pedidoAdaptado.aclaracion"
				]
	}

	/**Crea los labels que muestran los datos del pedido */
	def void datosPlatos(Panel mainPanel) 
	{
		var panelDatosPlatos = new Panel(mainPanel)
		panelDatosPlatos.layout = new ColumnLayout(2)

		new Label(panelDatosPlatos).text = "Cliente"

		new Label(panelDatosPlatos).value <=> "pedidoAdaptado.miembro.nombre"

		new Label(panelDatosPlatos).text = "Costo de envío"

		new Label(panelDatosPlatos).bindValueToProperty("pedidoAdaptado.costoDeRetiro").transformer = new PrecioTransformer

		new Label(panelDatosPlatos).text = "Monto total"
	
		new Label(panelDatosPlatos).bindValueToProperty("precio").transformer = new PrecioTransformer
		
		new Label(panelDatosPlatos).text = "Hora"

		new Label(panelDatosPlatos).value <=> "hora"
	}

	/**Define los botones que interactuan con la ventana del pedido (Aceptar y Cancelar) */
	def ultimosBotonesPlatos(Panel mainPanel) 
	{
		var panelUltimosBotonesPlatos = new Panel(mainPanel)
		panelUltimosBotonesPlatos.layout = new HorizontalLayout

		new Button(panelUltimosBotonesPlatos) => 
			[
				caption = "Aceptar"
				onClick [
							this.accept
							disableOnError
						]
			]
		
		new Button(panelUltimosBotonesPlatos) => 
			[
				bindVisibleToProperty("noEstaCerrado")	//Si el pedido esta cerrado no se muestra el boton
				caption = "Cancelar"
				onClick [	close	]
			]
		
	}
	
	override executeTask()
	{
		super.executeTask
		this.modelObject.aceptarCambios
	}
}
