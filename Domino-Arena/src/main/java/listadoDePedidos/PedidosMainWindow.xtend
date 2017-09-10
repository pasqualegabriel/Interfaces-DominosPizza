package listadoDePedidos

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.bindings.NotNullObservable
import pedido.EditarPedidorWindow

class PedidosMainWindow extends SimpleWindow<PedidosAppModel> {
	
	new(WindowOwner parent, PedidosAppModel model) {
		super(parent, model)
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Dominos Pizza"
		// decimos que su layout va a ser vertical
		mainPanel.layout = new VerticalLayout


		// Agregamos el contenido a nuestro panel que van a ser 2 paneles mas!
		new Label(mainPanel) => [
			text = "Pedidos Abiertos"
		]
		this.panelDePedidos(mainPanel)

		this.panelDeBotones(mainPanel)

	}

	def panelDePedidos(Panel mainPanel) {
// 		decimos que su layout va a ser vertical
		var panelPedidos = new Panel(mainPanel)
		panelPedidos.layout = new HorizontalLayout

		
		val tablaPedidos = new Table<AdapterPedido>(panelPedidos, typeof(AdapterPedido))
		tablaPedidos => [
			numberVisibleRows = 5
			items <=> "pedidos"
			value <=> "pedidoSeleccionado"
		]

		new Column(tablaPedidos) => [
			title = "Pedido"
			bindContentsToProperty("nombre")
		]

		new Column(tablaPedidos) => [
			title = "Estado"
			bindContentsToProperty("estadoActual")
		]

		new Column(tablaPedidos) => [
			title = "Monto"
			bindContentsToProperty("precio")
		]

		new Column(tablaPedidos) => [
			title = "Hora"
			bindContentsToProperty("hora")
		]
		
		this.botonesDeTablaDePedido(panelPedidos)
	}

	def botonesDeTablaDePedido(Panel panelPedidos) 
	{
		val elementoSeleccionado= new NotNullObservable("pedidoSeleccionado")
		var panelTablaDePedido = new Panel(panelPedidos) 
		panelTablaDePedido.layout = new VerticalLayout
		
		new Button(panelTablaDePedido) => [
			caption = "<<"
			onClick [ 
				modelObject.anteriorEstado
				bindEnabled(elementoSeleccionado)
			]
		]
		
		new Button(panelTablaDePedido) => [
			caption = ">>"
			onClick [ 
				modelObject.siguienteEstado
				bindEnabled(elementoSeleccionado)
			]
		]
	
		
		
		new Button(panelTablaDePedido) => [
			caption = "Cancelar"
			onClick [ 
				modelObject.cancelarPedidoSeleccionado
				bindEnabled(elementoSeleccionado)
			]
			
		]
		
		new Button(panelTablaDePedido) => [
			caption = "Editar"
			onClick([new EditarPedidorWindow(this, modelObject.pedidoSeleccionado).open])
			bindEnabled(elementoSeleccionado)
		]
	}


	def panelDeBotones(Panel panel) 
	{
		var panelBotones = new Panel(panel) 
		panelBotones.layout = new HorizontalLayout
		
		new Button(panelBotones) => [
			caption = "Menú"
		]
		
		new Button(panelBotones) => [
			caption = "Pedidos Cerrados"
		]
		
		new Button(panelBotones) => [
			caption = "Salir"
			onClick[this.close]
		]
	
	}

}




