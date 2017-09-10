package pedido

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.aop.windows.TransactionalDialog
import listadoDePedidos.AdapterPedido
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.TextBox
import plato.PlatoWindow
import plato.PlatoAdapter
import estados.EstadoDePedido

class EditarPedidorWindow extends TransactionalDialog<AdapterPedido> {

	new(WindowOwner owner, AdapterPedido model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Editar un Pedido"

		mainPanel.layout = new VerticalLayout()

		estados(mainPanel)

		platos(mainPanel)

	}

	def estados(Panel mainPanel) {

		var panelEstados = new Panel(mainPanel)
		panelEstados.layout = new HorizontalLayout

		new Label(panelEstados).text = "Estado"

		val estadoSeleccionado = new NotNullObservable("estadoActual")

		new Selector<AdapterPedido>(panelEstados) => [
			allowNull(false)
			(items <=> "estadosSelector").adaptWith(typeof(EstadoDePedido), "nombre")
			value <=> "cambioDeEstado"
			
			bindEnabled(estadoSeleccionado)
		]
	}

	def platos(Panel mainPanel) {

		var panelPlatos = new Panel(mainPanel)
		panelPlatos.layout = new ColumnLayout(2)

		tablaPlatos(panelPlatos)

		botonesPlatos(panelPlatos)

		aclaracionesPlatos(mainPanel)

		datosPlatos(mainPanel)

		ultimosBotonesPlatos(mainPanel)
	}

	def tablaPlatos(Panel panelPlatos) {
		var panelTablaPlatos = new Panel(panelPlatos)
		panelTablaPlatos.layout = new VerticalLayout

		new Label(panelTablaPlatos).text = "Platos"

		val tablaPedidos = new Table(panelTablaPlatos, typeof(PlatoAdapter)) => [
			numberVisibleRows = 6
			items <=> "platos"
			value <=> "platoSeleccionado"
		]

		new Column(tablaPedidos) => [
			title = "Nombre"
			bindContentsToProperty("nombre")
		]

		new Column(tablaPedidos) => [
			title = "Tamaño"
			bindContentsToProperty("tamanio.nombre")
		]

		new Column(tablaPedidos) => [
			title = "Precio"
			bindContentsToProperty("precio")
		]

	}

	def botonesPlatos(Panel panelPlatos) {
		var panelBotonesPlatos = new Panel(panelPlatos)
		panelBotonesPlatos.layout = new VerticalLayout

		new Button(panelBotonesPlatos) => [
			caption = "Agregar"
			onClick [new PlatoWindow(this, new PlatoAdapter(new Plato)).open
				
					]
		]

		new Button(panelBotonesPlatos) => [
			caption = "Editar"
			onClick [ 	
						modelObject.platoSeleccionado.sizeSelect  = modelObject.platoSeleccionado.plato.tamanio
						modelObject.platoSeleccionado.pizzaSelect = modelObject.platoSeleccionado.plato.pizza
						new PlatoWindow(this,  modelObject.platoSeleccionado).open
					]
		]

		new Button(panelBotonesPlatos) => [
			caption = "Eliminar"
			onClick []
		]
	}

	def aclaracionesPlatos(Panel mainPanel) {

		new Label(mainPanel).text = "Aclaraciones"

		new TextBox(mainPanel) => [
			width = 20
			fontSize = 9
			value <=> "pedido.aclaracion"
		]
	}

	def void datosPlatos(Panel mainPanel) {

		var panelDatosPlatos = new Panel(mainPanel)
		panelDatosPlatos.layout = new ColumnLayout(2)

		new Label(panelDatosPlatos).text = "Cliente"

		new Label(panelDatosPlatos).value <=> "pedido.miembro.nombre"

		new Label(panelDatosPlatos).text = "Costo de envío"

		new Label(panelDatosPlatos).text = "$15"

		new Label(panelDatosPlatos).text = "Monto total"

		new Label(panelDatosPlatos).value <=> "pedido.calcularPrecio"

		new Label(panelDatosPlatos).text = "Fecha"

		new Label(panelDatosPlatos).value <=> "pedido.fecha"
	}

	def ultimosBotonesPlatos(Panel mainPanel) {

		var panelUltimosBotonesPlatos = new Panel(mainPanel)
		panelUltimosBotonesPlatos.layout = new HorizontalLayout

		new Button(panelUltimosBotonesPlatos) => [
			caption = "Aceptar"
			onClick []
		]

		new Button(panelUltimosBotonesPlatos) => [
			caption = "Cancelar"
			onClick [close]
		]
	}

}
