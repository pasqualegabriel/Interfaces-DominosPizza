import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*

class TestEstadoEntregado {

	//Estructura
	EstadoDePedido	unEstadoEntregadoTest
	EstadoDePedido  otroEstadoEntregadoTest
	@Mock Pedido 	unPedidoMock
	
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoEntregadoTest		= spy(new Entregado)
		otroEstadoEntregadoTest		= new Entregado
		
	}
	
	@Test
	def cuandoElEstadoEntregadoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoEntregadoTest.siguiente(unPedidoMock)
		verify(unEstadoEntregadoTest).siguiente(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoEntregadoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoEntregadoTest.anterior(unPedidoMock)
		verify(unEstadoEntregadoTest).anterior(unPedidoMock)
	}
	@Test
	def cuandoElEstadoEntregaSeLePidePrevioYEntregadoDevuelveElEstadoEntregado(){
		var estadoRespuesta = new Entregado 
		assertEquals(otroEstadoEntregadoTest.previo.class,estadoRespuesta.class)
		assertEquals(otroEstadoEntregadoTest.proximo.class,estadoRespuesta.class)
	}
}