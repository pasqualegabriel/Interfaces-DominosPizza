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
import listadoDePedidos.DominoPizzaAppModel
import listadoDePedidos.PedidoAppModel
import pedido.PedidoWindowEditar
import DominoPizzaInicio.TablaPedido

class MainWindowListaPedidosCerrados extends SimpleWindow<DominoPizzaAppModel> 
{
	
	new(WindowOwner parent) {
		super(parent, new DominoPizzaAppModel)
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
		
		val tabla=new TablaPedido(mainPanel)
		tabla.tablaPedidos(mainPanel,"itemsPedidosCerrados",
		"Fecha","fecha","Espera","tiempoDeEspera","Pedidos Cerrados")
//		val tablaDePedidosCerrados = new Table<PedidoAppModel>(mainPanel,typeof(PedidoAppModel))
//			tablaDePedidosCerrados =>	[
//											numberVisibleRows = 5
//											items <=> "itemsPedidosCerrados"
//											value <=> "pedidoSelectItems"
//										]
//										
//		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Pedido","nombre")
//		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Estado","nombreDeEstado")
//		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Fecha","fecha")
//		this.columnaTablaPedidosCerrados(tablaDePedidosCerrados,"Tiempo De Espera","tiempoDeEspera")
	}
	
	def columnaTablaPedidosCerrados(Table<PedidoAppModel> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 	[
											title = unTitulo
											bindContentsToProperty(propiedadABindear)
										]
	}
	
	def botonesInferiores(Panel mainPanel)
	{
		val unPedidoCerradoSeleccionado	= new NotNullObservable("pedidoSelectItem")
		var panelBotonesInferiores 		= new Panel(mainPanel) 
		panelBotonesInferiores.layout 	= new HorizontalLayout
		
		new Button(panelBotonesInferiores)=>[
												caption = "Ver"
												onClick [	new PedidoWindowEditar(this, modelObject.pedidoSelectItem,false).open	]
												bindEnabled(unPedidoCerradoSeleccionado)
											]
		
		new Button(panelBotonesInferiores)=>[
												caption = "Volver"
												onClick [	this.close	]
											]
	
	}
	
}