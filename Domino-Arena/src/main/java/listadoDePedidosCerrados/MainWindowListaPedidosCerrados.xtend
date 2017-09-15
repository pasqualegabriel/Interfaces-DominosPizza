package listadoDePedidosCerrados

//import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import pedido.PedidoWindowEditar
import DominoPizzaInicio.TablaPedido
import DominoPizzaInicio.DominoPizzaAppModel

class MainWindowListaPedidosCerrados extends SimpleWindow<DominoPizzaAppModel> 
{
	
	new(WindowOwner parent) {
		super(parent, new DominoPizzaAppModel)
	}
	
	override protected addActions(Panel actionsPanel){}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = "Dominos Pizza"
		mainPanel.layout = new VerticalLayout
		
		this.tablaDePedidosCerrados(mainPanel)
		
		this.botonesInferiores(mainPanel)
	}

	def tablaDePedidosCerrados(Panel mainPanel)
	{
		
		val tabla=new TablaPedido(mainPanel)
		tabla.tablaPedidos(mainPanel,"itemsPedidosCerrados",
		"Fecha","fecha","Espera","tiempoDeEspera","Pedidos Cerrados")
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