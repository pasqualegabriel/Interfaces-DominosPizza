package adapterListadoDePedidos

import org.junit.Test
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.*;
import org.mockito.MockitoAnnotations
import pedido.Pedido
import domino.Miembro
import pedido.Local
import estados.ListoParaRetirar
import static org.junit.Assert.*
import estados.Preparando
import listadoDePedidos.PedidoAppModel
import DominoPizzaInicio.DominoPizzaAppModel

class TestPedidosAppModel {
	@Mock Miembro 	unMiembroMock	
	Pedido  		unSpyPedido
	PedidoAppModel 	unAdapterSpy
	DominoPizzaAppModel unPedidosAppModel
	
	@Before
	def void setUp() {
		
		MockitoAnnotations.initMocks(this)
		unSpyPedido								= spy(new Pedido(unMiembroMock))
		unSpyPedido.formaDeRetiro				= new Local
		unAdapterSpy 							= spy(new PedidoAppModel(unSpyPedido))
		unPedidosAppModel						= new DominoPizzaAppModel()
		unPedidosAppModel.pedidoSelectItem  	= unSpyPedido
		
	}
	@Test
	def test01UnPedidosAppModelSabePedirleASuPedidoSeleccionadoQueAvanzeAlSiguienteEstado(){
		var estadoRespuesta				= new ListoParaRetirar
		unPedidosAppModel.siguienteEstadoPedidoSeleccionado
		verify(unAdapterSpy).pasarASiguienteEstado
		verify(unSpyPedido).siguiente
		assertEquals(unSpyPedido.estadoActual.class,estadoRespuesta.class)
	}
	
	@Test
	def test02UnPedidosAppModelSabePedirleASuPedidoSeleccionadoQueAvanzeAlSiguienteEstado(){
		var estadoRespuesta				= new Preparando
		unPedidosAppModel.anteriorEstadoPedidoSeleccionado
		verify(unAdapterSpy).pasarAAnteriorEstado
		verify(unSpyPedido).anterior
		assertEquals(unSpyPedido.estadoActual.class,estadoRespuesta.class)
	}
}