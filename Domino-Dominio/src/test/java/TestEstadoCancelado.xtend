import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.Cancelado

class TestEstadoCancelado {
	//Estructura
	EstadoDePedido	unEstadoCanceladoTest
	EstadoDePedido  otroEstadoCanceladoTest
	@Mock Pedido 	unPedidoMock
		
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoCanceladoTest		= spy(new Cancelado)
		otroEstadoCanceladoTest		= new Cancelado
	}
	
	@Test
	def cuandoElEstadoCanceladoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoCanceladoTest.siguiente(unPedidoMock)
		verify(unEstadoCanceladoTest).siguiente(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoCanceladoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoCanceladoTest.anterior(unPedidoMock)
		verify(unEstadoCanceladoTest).anterior(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoCanceladoSeLePidePrevioYEntregadoDevuelveElEstadoCancelado(){
		var estadoRespuesta = new Cancelado 
		assertEquals(otroEstadoCanceladoTest.previo.class,estadoRespuesta.class)
		assertEquals(otroEstadoCanceladoTest.proximo.class,estadoRespuesta.class)
	}	
}