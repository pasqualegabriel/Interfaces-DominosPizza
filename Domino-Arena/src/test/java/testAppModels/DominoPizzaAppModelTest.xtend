package testAppModels

import org.junit.Test
import pedido.Pedido
import org.junit.Before
import persistencia.HomePedido
import static org.junit.Assert.*
import persistencia.Bootstrap

class DominoPizzaAppModelTest 
{
	Bootstrap elBootstrap
	DominoPizzaInicio.DominoPizzaAppModel unDominoPizzaAppModel
	Pedido unPedidoAbiertoSeleccionado
	
	
	@Before
	def void SetUp()
	{
		elBootstrap 			= new Bootstrap
		elBootstrap.run
		unDominoPizzaAppModel 	= new DominoPizzaInicio.DominoPizzaAppModel	
	}
	
	@Test
	def Un_Pedido_Seleccionado_Al_Cancelarlo_Pasa_Al_Estado_Cancelado_Y_Pasa_De_La_Lista_Abierta_A_La_Cerrada()
	{
		//Setup
		unPedidoAbiertoSeleccionado	= HomePedido.instance.pedidosAbiertos.get(0)
		unDominoPizzaAppModel.pedidoSelectItem = unPedidoAbiertoSeleccionado
		//Exercise
		unDominoPizzaAppModel.cancelarPedidoSeleccionado
		
		//Test
		assertTrue(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase("Cancelado"))
		assertFalse(unDominoPizzaAppModel.itemsPedidosAbiertos.contains(unPedidoAbiertoSeleccionado))
		assertTrue(unDominoPizzaAppModel.itemsPedidosCerrados.contains(unPedidoAbiertoSeleccionado))
		assertNull(unDominoPizzaAppModel.pedidoSelectItem)
	}
	
	@Test
	def Un_Pedido_Seleccionado_Si_Se_Pasa_A_Estado_Siguiente_Y_No_Pasa_A_Entregado_Pasa_A_Su_Siguiente_Y_Sigue_En_La_Lista_De_Pedidos_Abiertos()
	{
		//Setup
		unPedidoAbiertoSeleccionado				= HomePedido.instance.pedidosAbiertos.get(0)
		unDominoPizzaAppModel.pedidoSelectItem 	= unPedidoAbiertoSeleccionado
		var estadoAntesDePasarAlSiguiente		= unPedidoAbiertoSeleccionado.estadoActual.nombre
		var estadoSiguienteEsperado				= unPedidoAbiertoSeleccionado.estadoActual.proximo.nombre
		//Exercise
		unDominoPizzaAppModel.siguienteEstadoPedidoSeleccionado
		
		//Test
		assertFalse(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase(estadoAntesDePasarAlSiguiente))
		assertTrue(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase(estadoSiguienteEsperado))
		assertFalse(unDominoPizzaAppModel.itemsPedidosCerrados.contains(unPedidoAbiertoSeleccionado))
		assertTrue(unDominoPizzaAppModel.itemsPedidosAbiertos.contains(unPedidoAbiertoSeleccionado))
	}
	
	@Test
	def Un_Pedido_Seleccionado_Si_Se_Pasa_A_Estado_Siguiente_Y_Pasa_A_Entregado_Pasa_A_Su_Siguiente_Y_Pasa_A_La_Lista_De_Pedidos_Cerrados()
	{
		//Setup
		unPedidoAbiertoSeleccionado				= HomePedido.instance.pedidosAbiertos.get(2)
		unDominoPizzaAppModel.pedidoSelectItem 	= unPedidoAbiertoSeleccionado
		var estadoAntesDePasarAlSiguiente		= unPedidoAbiertoSeleccionado.estadoActual.nombre
		//Exercise
		unDominoPizzaAppModel.siguienteEstadoPedidoSeleccionado
		
		//Test
		assertFalse(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase(estadoAntesDePasarAlSiguiente))
		assertTrue(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase("Entregado"))
		assertFalse(unDominoPizzaAppModel.itemsPedidosAbiertos.contains(unPedidoAbiertoSeleccionado))
		assertTrue(unDominoPizzaAppModel.itemsPedidosCerrados.contains(unPedidoAbiertoSeleccionado))
	}
	
	@Test
	def Un_Pedido_Seleccionado_No_Esta_En_Estado_Preparando_Y_Pasa_A_Estado_Anterior_Lo_Hace()
	{
		//Setup
		unPedidoAbiertoSeleccionado				= HomePedido.instance.pedidosAbiertos.get(2)
		unDominoPizzaAppModel.pedidoSelectItem 	= unPedidoAbiertoSeleccionado
		var estadoAntesDePasarAlAnterior		= unPedidoAbiertoSeleccionado.estadoActual.nombre
		var estadoAnteriorEsperado				= unPedidoAbiertoSeleccionado.estadoActual.previo.nombre
		//Exercise
		unDominoPizzaAppModel.anteriorEstadoPedidoSeleccionado
		
		//Test
		assertFalse(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase(estadoAntesDePasarAlAnterior))
		assertTrue(unPedidoAbiertoSeleccionado.estadoActual.nombre.equalsIgnoreCase(estadoAnteriorEsperado))
	}
	
	@Test(expected=typeof(DominoPizzaInicio.StateException))
	def Un_Pedido_Seleccionado_Esta_En_Estado_Preparando_E_Intenta_Pasar_A_Un_Estado_Anterior_Levanta_Una_Excepcion()
	{
		//Setup
		unPedidoAbiertoSeleccionado				= HomePedido.instance.pedidosAbiertos.get(1)
		unDominoPizzaAppModel.pedidoSelectItem 	= unPedidoAbiertoSeleccionado
		//Exercise
		unDominoPizzaAppModel.anteriorEstadoPedidoSeleccionado
	}
	
}
			