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
import listadoDePedidos.PedidoAppModel

class PedidoWindowEditar extends TransactionalDialog<PedidoAppModel> {

	new(WindowOwner owner, Pedido pedido, boolean b) {
		
		super(owner, new PedidoAppModel(pedido,b))
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Editar un Pedido"

		mainPanel.layout = new VerticalLayout()

		selectorEstado(mainPanel)

		tablaPlato(mainPanel)
		aclaracionesPlatos(mainPanel)
		datosPlatos(mainPanel)
		ultimosBotonesPlatos(mainPanel)

	}

	def selectorEstado(Panel mainPanel) {

		var panelEstados = new Panel(mainPanel)
		panelEstados.layout = new HorizontalLayout

		new Label(panelEstados).text = "Estado"

		new Selector<EstadoDePedido>(panelEstados) => [
			bindEnabledToProperty("pedidoCerrado")
			allowNull(false)
			(items <=> "estadosSelector").adaptWith(typeof(EstadoDePedido), "nombre")
			value <=> "cambioDeEstado"
			onAccept(execute(modelObject,"cambiarAEstadoSeleccionado") )
		]
	}

	def tablaPlato(Panel mainPanel) {

		var panelPlatos = new Panel(mainPanel)
		panelPlatos.layout = new ColumnLayout(2)

		tablaPlatos(panelPlatos)

		botonesPlatos(panelPlatos)

	}

	def tablaPlatos(Panel panelPlatos) {
		var panelTablaPlatos = new Panel(panelPlatos)
		panelTablaPlatos.layout = new VerticalLayout

		new Label(panelTablaPlatos).text = "Platos"

		val tablaPedidos = new Table(panelTablaPlatos, typeof(PedidoAppModel)) => [
			bindEnabledToProperty("pedidoCerrado")
			numberVisibleRows = 6
			items <=> "itemsPlatos"
			value <=> "platoSeleccionado"
		]

		new Column(tablaPedidos) => [
			title = "Nombre"
			bindContentsToProperty("platoSeleccionado.pizza.nombre")
		]

		new Column(tablaPedidos) => [
			title = "Tamaño"
			bindContentsToProperty("platoSeleccionado.tamanio.nombre")
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
			bindEnabledToProperty("pedidoCerrado")
			caption = "Agregar"
			onClick [
						new AgregarPlatoWindow(this).open
					]
		]

		new Button(panelBotonesPlatos) => [
			bindEnabledToProperty("pedidoCerrado")
			caption = "Editar"
			onClick [
//				modelObject.platoSeleccionado.sizeSelect = modelObject.platoSeleccionado.plato.tamanio
//				modelObject.platoSeleccionado.pizzaSelect = modelObject.platoSeleccionado.plato.pizza
//				modelObject.platoSeleccionado.suAdapterPedido = modelObject
				new EditarPlatoWindow(this, modelObject.platoSeleccionado).open
			]
		]

		new Button(panelBotonesPlatos) => [
			bindEnabledToProperty("pedidoCerrado")
			caption = "Eliminar"
			onClick [
				modelObject.eliminarPlato()
			]
		]
	}

	def aclaracionesPlatos(Panel mainPanel) {

		new Label(mainPanel).text = "Aclaraciones"

		new TextBox(mainPanel) => [
			bindEnabledToProperty("pedidoCerrado")
			width = 20
			fontSize = 9
			value <=> "pedidoAdaptado.aclaracion"
		]
	}

	def void datosPlatos(Panel mainPanel) {

		var panelDatosPlatos = new Panel(mainPanel)
		panelDatosPlatos.layout = new ColumnLayout(2)

		new Label(panelDatosPlatos).text = "Cliente"

		new Label(panelDatosPlatos).value <=> "pedidoAdaptado.miembro.nombre"

		new Label(panelDatosPlatos).text = "Costo de envío"

		new Label(panelDatosPlatos).value <=> "costoDeEnvio"

		new Label(panelDatosPlatos).text = "Monto total"
	
		new Label(panelDatosPlatos).value <=> "precio"

		new Label(panelDatosPlatos).text = "Hora"

		new Label(panelDatosPlatos).value <=> "hora"
	}

	def ultimosBotonesPlatos(Panel mainPanel) {

		var panelUltimosBotonesPlatos = new Panel(mainPanel)
		panelUltimosBotonesPlatos.layout = new HorizontalLayout

		new Button(panelUltimosBotonesPlatos) => [
			caption = "Aceptar"
			onClick [
				accept
				disableOnError
			]
		]

		new Button(panelUltimosBotonesPlatos) => [
			caption = "Cancelar"
			onClick [close]
		]
	}


}
