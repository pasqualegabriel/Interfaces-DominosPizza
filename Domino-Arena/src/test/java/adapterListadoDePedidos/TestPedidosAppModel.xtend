package adapterListadoDePedidos

import org.junit.Test
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.*;
import org.mockito.MockitoAnnotations
import pedido.Pedido
import domino.Miembro
import listadoDePedidos.AdapterPedido
import pedido.Local
import listadoDePedidos.PedidosAppModel
import persistencia.Home
import estados.ListoParaRetirar
import static org.junit.Assert.*
import estados.Preparando

class TestPedidosAppModel {
	@Mock Miembro 	unMiembroMock	
	Pedido  		unSpyPedido
	AdapterPedido 	unAdapterSpy
	PedidosAppModel unPedidosAppModel
	
	@Before
	def void setUp() {
		
		MockitoAnnotations.initMocks(this)
		unSpyPedido								= spy(new Pedido(unMiembroMock))
		unSpyPedido.formaDeRetiro				= new Local
		unAdapterSpy 							= spy(new AdapterPedido(unSpyPedido,1))
		unPedidosAppModel						= new PedidosAppModel(Home.instance)
		unPedidosAppModel.pedidoSeleccionado 	= unAdapterSpy
		
	}
	@Test
	def test01UnPedidosAppModelSabePedirleASuPedidoSeleccionadoQueAvanzeAlSiguienteEstado(){
		var estadoRespuesta				= new ListoParaRetirar
		unPedidosAppModel.siguienteEstado
		verify(unAdapterSpy).siguienteEstado
		verify(unSpyPedido).siguiente
		assertEquals(unSpyPedido.estadoActual.class,estadoRespuesta.class)
	}
	
	@Test
	def test02UnPedidosAppModelSabePedirleASuPedidoSeleccionadoQueAvanzeAlSiguienteEstado(){
		var estadoRespuesta				= new Preparando
		unPedidosAppModel.anteriorEstado
		verify(unAdapterSpy).anteriorEstado
		verify(unSpyPedido).anterior
		assertEquals(unSpyPedido.estadoActual.class,estadoRespuesta.class)
	}
}