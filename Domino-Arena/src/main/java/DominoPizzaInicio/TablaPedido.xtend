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

class TablaPedido extends Panel {

	new(Container container) {
		super(container)
	}


	def tablaPedidos(Panel mainPanel, String listaDePedidos, String titulo3, String propiedad3, String titulo4,
		String propiedad4, String titulo) {
			
		var panelTablaPedidos = new Panel(mainPanel)
		panelTablaPedidos.layout = new VerticalLayout
		
		new Label(panelTablaPedidos) => [text = titulo]
		val tablaDePedidos = new Table<Pedido>(panelTablaPedidos, typeof(Pedido))
		tablaDePedidos => [

			numberVisibleRows = 5
			items <=> listaDePedidos
			value <=> "pedidoSelectItem"
		]
		this.columnaTablaPedidosSoloNombrePedido(tablaDePedidos,"Pedido","miembro.nombre")
		this.columnaTablaPedidosEstado(tablaDePedidos, "Estado", "estadoActual")
		this.columnaTablaPedidos(tablaDePedidos, titulo3, propiedad3)
		this.columnaTablaPedidos(tablaDePedidos, titulo4, propiedad4)

	}
	
	def columnaTablaPedidosEstado(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
			
		new Column(tablaDePedidos) => [

			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = [
				EstadoDePedido estadoDePedido | estadoDePedido.nombre
			]
		]
	}

	/**Define un predefinido para crear las columnas */
	def columnaTablaPedidos(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
		new Column(tablaDePedidos) => [

			title = unTitulo
			bindContentsToProperty(propiedadABindear)
		]
	}

	def columnaTablaPedidosSoloNombrePedido(Table<Pedido> tablaDePedidos, String unTitulo, String propiedadABindear) {
		new Column(tablaDePedidos) => [

			title = unTitulo
			bindContentsToProperty(propiedadABindear).transformer = [
				String nombreDelMiembroDelPedido | "Pedido de " + nombreDelMiembroDelPedido
			]
		]
	}

}
