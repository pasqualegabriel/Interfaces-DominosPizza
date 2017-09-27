package DominoPizzaInicio

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Table

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import pedido.Pedido
import org.uqbar.arena.layout.VerticalLayout
import estados.EstadoDePedido
import java.time.LocalDateTime

class TablaPedido extends Panel {

	new(Container container) 
	{	super(container)	}

	/**Genera La tabla para trabajar con una lista de pedidos, solo 
	 * genera las columanas de nombre de pedido y la columna de estado del pedido*/
	def tablaPedidos(Panel mainPanel, String listaDePedidos, String titulo) {
			
		var panelTablaPedidos = new Panel(mainPanel)
		panelTablaPedidos.layout = new VerticalLayout
		
		new Label(panelTablaPedidos) => [text = titulo]
		val tablaDePedidos = new Table<Pedido>(panelTablaPedidos, typeof(Pedido))
		tablaDePedidos =>[
							numberVisibleRows = 5
							items <=> listaDePedidos
							value <=> "pedidoSelectItem"
						 ]
		this.columnaTablaPedidosSoloNombrePedido(tablaDePedidos,"Pedido","miembro.nombre")
		this.columnaTablaPedidosEstado(tablaDePedidos, "Estado", "estadoActual")
		
		tablaDePedidos
	}
	
	/**Crea una columna para mostrar el estado de un pedido */
	def columnaTablaPedidosEstado(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
			
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = 
													[	
														EstadoDePedido estadoDePedido | 
														estadoDePedido.nombre
													] //Transforma al estado para que muestre el nombre
		]
	}

	/**Define un predefinido para crear las columnas */
	def columnaTablaPedidos(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear)
		]
	}

	/**Crea una columna para mostrar el nombre del pedido, el cual se compone con el nombre del cliente*/
	def columnaTablaPedidosSoloNombrePedido(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = 
													[	
														String nombreDelMiembroDelPedido | 
														"Pedido de " + nombreDelMiembroDelPedido
													] //Transforma el titulo para que muestre el con el nombre del cliente
		]
	}
	
	/**Crea una columna para mostrar la fecha de creacion del pedido*/
	def columnaTablaPedidosSoloFecha(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = 
													[ 
														LocalDateTime fechaDePedido | 
														fechaDePedido.toLocalDate.toString
													] //Transforma la fecha del pedido para que se muestre solo  como dd-mm-aaaa
		]
	}
	
	/**Crea una columna para mostrar el tiempo de demora que tubo un pedido desde que se preparo hasta que se entrego*/
	def columnaTablaPedidosSoloTiempoDeDemora(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = 
													[
														Integer tiempoDeEspera | 
														if (tiempoDeEspera == 0) "-" else '''«tiempoDeEspera» Min'''
													] /*Transforma el tiempo de demora para que se muestre com "x Min" 
													   * y en el caso que no tenga demora se meustre solo "-"*/
		]
	}
	
	/**Crea una columna para mostrar el precio total del pedido*/
	def columnaTablaPedidosSoloPrecio(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = [ Double precio | '''$ «precio»''']
													 //Transforma el Precio para que se muestre con el signo $
		]
	}
	
	/**Crea una columna para mostrar la hora en la cual se realizo el pedido*/
	def columnaTablaPedidosSoloHora(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) 
	{
		new Column(tablaDePedidos) => 
		[
			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = 
										[ 
											LocalDateTime fechaDePedido | 
											'''«fechaDePedido.toLocalTime.hour»:«fechaDePedido.toLocalTime.minute»''' 
										] //Transforma la fecha para que solo se muestre la hora del pedido
		]
	}

}
