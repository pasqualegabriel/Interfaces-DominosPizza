package listadoDePedidosCerrados

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import listadoDePedidos.AdapterPedido
import listadoDePedidos.PedidosAppModel

class MainWindowListaPedidosCerrados extends SimpleWindow<PedidosAppModel> 
{
	
	new(WindowOwner parent) {
		super(parent, new PedidosAppModel)
	}
	
	override protected addActions(Panel actionsPanel) 
	{
		//No se va a usar
	}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = "Dominos Pizza"
		mainPanel.layout = new VerticalLayout
		
		new Label(mainPanel).text = "Pedidos Cerrados"
		
		this.tablaDePedidosCerrados(mainPanel)
		
		this.botonesInferiores(mainPanel)
	}

	def tablaDePedidosCerrados(Panel mainPanel)
	{
		val tablaDePedidosCerrados = new Table<AdapterPedido>(mainPanel,typeof(AdapterPedido))
			tablaDePedidosCerrados =>	[
											numberVisibleRows = 5
											items <=> "listaDePedidosCerrados"
											value <=> "pedidoSeleccionado"
										]
										
		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Pedido","nombre")
		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Estado","nombreDeEstado")
		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Fecha","fecha")
		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Tiempo De Espera","tiempoDeEspera")
	}
	
	def columnaTablaPedidosCerrados(Table<AdapterPedido> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 	[
											title = unTitulo
											bindContentsToProperty(propiedadABindear)
										]
	}
	
	def botonesInferiores(Panel mainPanel)
	{
		val unPedidoCerradoSeleccionado	= new NotNullObservable("pedidoSeleccionado")
		var panelBotonesInferiores 		= new Panel(mainPanel) 
		panelBotonesInferiores.layout 	= new HorizontalLayout
		
		new Button(panelBotonesInferiores)=>[
												caption = "Ver"
												onClick [	]
												bindEnabled(unPedidoCerradoSeleccionado)
											]
		
		new Button(panelBotonesInferiores)=>[
												caption = "Volver"
												onClick [	this.close	]
											]
	
	}
	
}