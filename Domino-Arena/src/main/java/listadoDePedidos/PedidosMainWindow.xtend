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
import menuPizzas.MenuDeDominoMainWindow
import menuPizzas.MenuDeDominoAppModel
import listadoDePedidosCerrados.MainWindowListaPedidosCerrados
import pedido.PedidoWindowEditar

class PedidosMainWindow extends SimpleWindow<DominoPizzaAppModel> 
{
	
	new(WindowOwner parent) 
	{
		super(parent, new DominoPizzaAppModel)
	}
	
	override protected addActions(Panel actionsPanel) 
	{
		//No se Va A Usar
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = "Dominos Pizza"
		mainPanel.layout = new VerticalLayout
		
		new Label(mainPanel) => [ text = "Pedidos Abiertos" ]		
		this.panelDeListaPedidos(mainPanel)
		this.panelDeBotonesInferiores(mainPanel)
	}
	
	/**Define el panel donde se contendra la tabla de pedidos y los botones que interactuan con esta */
	def panelDeListaPedidos(Panel mainPanel)
	{
		var panelDeListaPedidos	= new Panel(mainPanel)
		panelDeListaPedidos.layout = new HorizontalLayout
		
		this.tablaListaDePedidos(panelDeListaPedidos)
		this.panelBotonesListaDePedidos(panelDeListaPedidos)
	}
	
	/**Define la tabla donde se Encuentra la lista de pedidos */
	def tablaListaDePedidos(Panel panelDeListaPedidos)
	{
		val tablaDePedidos = new Table<PedidoAppModel>(panelDeListaPedidos, typeof(PedidoAppModel))
		tablaDePedidos	=>	[
								numberVisibleRows = 5
								items <=> "itemsPedidosAbiertos"
								value <=> "pedidoSelectItems"
							]
		
		this.columnaTablaPedidos(tablaDePedidos,"Pedido","nombre")
		this.columnaTablaPedidos(tablaDePedidos,"Estado","estadoActual")
		this.columnaTablaPedidos(tablaDePedidos,"Monto","precio")
		this.columnaTablaPedidos(tablaDePedidos,"Hora","hora")
							
	}
	
	/**Define un predefinido para crear las columnas */
	def columnaTablaPedidos(Table<PedidoAppModel> tablaDePedidos, String unTitulo, String propiedadABindear) {
		new Column(tablaDePedidos) => 	[
										
											title = unTitulo
											bindContentsToProperty(propiedadABindear)
										]
	}
	
	/**Define Los botones que interactuan con la tabla de pedidos */
	def panelBotonesListaDePedidos(Panel panelDeListaPedidos)
	{
		val unPedidoSeleccionado= new NotNullObservable("pedidoSeleccionado")
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
											onClick [	new PedidoWindowEditar(this, modelObject.pedidoSelectItem, false).open	]
											bindEnabled(unPedidoSeleccionado)
										]
		
	}
	
	/**Define los botones de avance y retroceso de estado de los pedidos */
	def botonesAvanceRetroceso(Panel panelTablaDePedido) 
	{
		val unPedidoSeleccionado= new NotNullObservable("pedidoSeleccionado")
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