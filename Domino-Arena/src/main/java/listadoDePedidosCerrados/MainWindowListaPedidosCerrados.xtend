package listadoDePedidosCerrados

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import DominoPizzaInicio.TablaPedido
import arenaAppModels.DominoPizzaAppModel

/**Clase que se encarga de visualizar una ventana donde se listan los pedidos cerrados. En esta ventana 
 * se puede acceder a un pedido cerrado y ver su contenido(pero no se puede modificar)*/
class MainWindowListaPedidosCerrados extends SimpleWindow<DominoPizzaAppModel> 
{	
	new(WindowOwner parent) 
	{	super(parent, new DominoPizzaAppModel)	}
	
	override protected addActions(Panel actionsPanel)
	{/*Sin Uso*/}
	
	override protected createFormPanel(Panel mainPanel) 
	{
		title = "Dominos Pizza"
		mainPanel.layout = new VerticalLayout
		
		this.tablaDePedidosCerrados(mainPanel)
		this.botonesInferiores(mainPanel)
	}

	/**Crea la tabla que lista los pedidos cerrados */
	def tablaDePedidosCerrados(Panel mainPanel)
	{
		val tabla		= new TablaPedido(mainPanel)
		var tablaPedidos= tabla.tablaPedidos(mainPanel,"itemsPedidosCerrados","Pedidos Cerrados")
		tabla.columnaTablaPedidosSoloFecha(tablaPedidos,"Fecha","fecha")
		tabla.columnaTablaPedidosSoloTiempoDeDemora(tablaPedidos,"Tiempo De Espera","tiempoDeEspera")
	}
	
	/**Crea Los botones para visualizar el pedido cerrado y el de cierre de ventana */
	def botonesInferiores(Panel mainPanel)
	{
		val unPedidoCerradoSeleccionado	= new NotNullObservable("pedidoSelectItem")
		var panelBotonesInferiores 		= new Panel(mainPanel) 
		panelBotonesInferiores.layout 	= new HorizontalLayout
		
		new Button(panelBotonesInferiores)=>[
												caption = "Ver"
												onClick [	new PedidoCerradoWindow(this, modelObject.pedidoSelectItem).open	]
												bindEnabled(unPedidoCerradoSeleccionado)	//Habilita el Boton si hay un pedido seleccionado
											]
		
		new Button(panelBotonesInferiores)=>[
												caption = "Volver"
												onClick [	this.close	]
											]
	}
	
}