package DominoPizzaInicio

//import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import listadoDePedidos.DominoPizzaAppModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import menuPizzas.MenuDeDominoMainWindow
import listadoDePedidosCerrados.MainWindowListaPedidosCerrados
import org.uqbar.arena.bindings.NotNullObservable
import menuPizzas.MenuDeDominoAppModel
import pedido.PedidoWindowEditar

class DominoPizzaWindow extends SimpleWindow<DominoPizzaAppModel> {
	
	new(WindowOwner parent, DominoPizzaAppModel model) {
		super(parent, model)
	}
	
	override protected addActions(Panel actionsPanel) {}
	
	override protected createFormPanel(Panel mainPanel) {
		this.title = "Domino pizza"
		mainPanel.layout = new VerticalLayout
		
		panelDeListaPedidos(mainPanel)
		panelDeBotonesInferiores(mainPanel)
	}
	
	/**Define el panel donde se contendra la tabla de pedidos y los botones que interactuan con esta */
	def panelDeListaPedidos(Panel mainPanel)
	{
		var panelDeListaPedidos	= new Panel(mainPanel)
		panelDeListaPedidos.layout = new HorizontalLayout
		
		val tabla=new TablaPedido(mainPanel)
		tabla.tablaPedidos(mainPanel,"itemsPedidosAbiertos",
		"Monto","calcularPrecio","Hora","fecha.toLocalTime","Pedidos Abiertos")
		
		this.panelBotonesListaDePedidos(panelDeListaPedidos)
	}
	
		
	/**Define Los botones que interactuan con la tabla de pedidos */
	def panelBotonesListaDePedidos(Panel panelDeListaPedidos)
	{
		val unPedidoSeleccionado= new NotNullObservable("pedidoSelectItem")
		var panelTablaDePedido = new Panel(panelDeListaPedidos) 
		panelTablaDePedido.layout = new VerticalLayout
		
		
		this.botonesAvanceRetroceso(panelTablaDePedido)
	
		new Button(panelTablaDePedido)=>[
											caption = "Cancelar"
											onClick [	modelObject.cerrarPedidoSeleccionado()	]
											bindEnabled(unPedidoSeleccionado)
										]
		
		new Button(panelTablaDePedido)=>[
											caption = "Editar"
											onClick [	new PedidoWindowEditar(this,modelObject.pedidoSelectItem,true).open	]
											bindEnabled(unPedidoSeleccionado)
										]
		
	}
	
	/**Define los botones de avance y retroceso de estado de los pedidos */
	def botonesAvanceRetroceso(Panel panelTablaDePedido) 
	{
		val unPedidoSeleccionado= new NotNullObservable("pedidoSelectItem")
		var panelRetrocederAvanzar = new Panel(panelTablaDePedido) 
		panelRetrocederAvanzar.layout = new HorizontalLayout
		new Button(panelRetrocederAvanzar)=>[
												caption = "<<"
												onClick [	modelObject.anteriorEstadoPedidoSeleccionado()	]
												bindEnabled(unPedidoSeleccionado)
											]
		
		new Button(panelRetrocederAvanzar)=>[
												caption = ">>"
												onClick [	modelObject.siguienteEstadoPedidoSeleccionado()	]
												bindEnabled(unPedidoSeleccionado)
											]
	}
	
	/**Define los botones de avance y retroceso de estado de los pedidos */
	def panelDeBotonesInferiores(Panel MainPanel)
	{
		var panelBotonesInferiores = new Panel(MainPanel) 
		panelBotonesInferiores.layout = new HorizontalLayout
		new Button(panelBotonesInferiores)=>[
												caption = "Menú"
												onClick [ new MenuDeDominoMainWindow(this, new MenuDeDominoAppModel).open  
													//Por que hay q pasarle el appModel de menu????
												]
											]
		
		new Button(panelBotonesInferiores)=>[
												caption = "Pedidos Cerrados"
												onClick [	new MainWindowListaPedidosCerrados(this).open	]
											]
											
		new Button(panelBotonesInferiores)=>[
												caption = "Salir"
												onClick [	this.close	]
											]
	}
	

	
}
