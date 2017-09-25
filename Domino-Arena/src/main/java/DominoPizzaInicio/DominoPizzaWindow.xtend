package DominoPizzaInicio

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import menuPizzas.MenuDeDominoMainWindow
import listadoDePedidosCerrados.MainWindowListaPedidosCerrados
import org.uqbar.arena.bindings.NotNullObservable
import menuPizzas.MenuDeDominoAppModel
import pedido.PedidoWindowEditar
import org.uqbar.commons.model.exceptions.UserException

/**Clase que genera y muestra la ventana donde se muestran los Pedidos Abiertos. En esta ventana se puede
 * hacer avanzar o retroceder el estado de un pedido, se lo puede cancelar y tambien se puede acceder a la 
 * ventana de edicion de pedido. Y se puede acceder a la ventana de pedidos cerrados y la ventana del menu*/
class DominoPizzaWindow extends SimpleWindow<DominoPizzaAppModel> 
{
	new(WindowOwner unaDominosPizzaMainWindow) 
	{	super(unaDominosPizzaMainWindow, new DominoPizzaAppModel)	}

	override protected addActions(Panel actionsPanel) {}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Domino pizza"
		mainPanel.layout = new VerticalLayout

		panelDeListaPedidos(mainPanel)
		panelDeBotonesInferiores(mainPanel)
	}

	/**Define el panel donde se contendra la tabla de pedidos y los botones que interactuan con esta */
	def panelDeListaPedidos(Panel mainPanel) {

		var panelDeListaPedidos = new Panel(mainPanel)
		panelDeListaPedidos.layout = new HorizontalLayout

		val tabla = new TablaPedido(panelDeListaPedidos)

		var tablaPedidosAbiertos = tabla.tablaPedidos(panelDeListaPedidos, "itemsPedidosAbiertos", "Pedidos Abiertos")
		tabla.columnaTablaPedidosSoloPrecio(tablaPedidosAbiertos, "Precio", "precio")
		tabla.columnaTablaPedidosSoloHora(tablaPedidosAbiertos, "Hora", "fecha")

		this.panelBotonesListaDePedidos(panelDeListaPedidos)
	}

	/**Define Los botones que interactuan con la tabla de pedidos */
	def panelBotonesListaDePedidos(Panel panelDeListaPedidos) {

		//Variable que habilita los botones dependiendo si hay un pedido seleccionado
		val unPedidoSeleccionado = new NotNullObservable("pedidoSelectItem")
		var panelTablaDePedido = new Panel(panelDeListaPedidos)
		panelTablaDePedido.layout = new VerticalLayout

		this.botonesAvanceRetroceso(panelTablaDePedido,unPedidoSeleccionado)

		new Button(panelTablaDePedido) => [
			caption = "Cancelar"
			onClick [modelObject.cancelarPedidoSeleccionado]
			bindEnabled(unPedidoSeleccionado)
		]

		new Button(panelTablaDePedido) => [
			caption = "Editar"
			onClick [	this.abrirDialogoDeEditarPedido	]
			bindEnabled(unPedidoSeleccionado)
		]

	}

	/**Abre la ventana para poder editar el pedido */
	def abrirDialogoDeEditarPedido() {
		val dialog = new PedidoWindowEditar(this, modelObject.pedidoSelectItem)
		dialog.onAccept [
			this.modelObject.pedidoSelectItem.setPrecio
			this.modelObject.getRepoDePedidosAbiertos
		]
		dialog.open
	}

	/**Define los botones de avance y retroceso de estado de los pedidos */
	def botonesAvanceRetroceso(Panel panelTablaDePedido, NotNullObservable verificadorDePedidoSeleccionado) {
		var panelRetrocederAvanzar = new Panel(panelTablaDePedido)
		panelRetrocederAvanzar.layout = new HorizontalLayout

		new Button(panelRetrocederAvanzar) => [
			caption = "<<"
			onClick [
				try 
				{	modelObject.anteriorEstadoPedidoSeleccionado()	}
				catch (StateException e) 
				{	throw new UserException("No se puede cambiar de estado")	}
			]
			bindEnabled(verificadorDePedidoSeleccionado)
		]

		new Button(panelRetrocederAvanzar) => [
			caption = ">>"
			onClick [	modelObject.siguienteEstadoPedidoSeleccionado	]
			bindEnabled(verificadorDePedidoSeleccionado)
		]
	}

	/**Define los botones para ir al menu de domino's pizza, de la lista de pedidos cerrados y para salir de la ventana*/
	def panelDeBotonesInferiores(Panel MainPanel) {

		var panelBotonesInferiores = new Panel(MainPanel)
		panelBotonesInferiores.layout = new HorizontalLayout

		new Button(panelBotonesInferiores) => [
			caption = "Menú"
			onClick [	new MenuDeDominoMainWindow(this, new MenuDeDominoAppModel).open	]
		]

		new Button(panelBotonesInferiores) => [
			caption = "Pedidos Cerrados"
			onClick [	new MainWindowListaPedidosCerrados(this).open	]
		]

		new Button(panelBotonesInferiores) => [
			caption = "Salir"
			onClick [	this.close	]
		]
	}

}
