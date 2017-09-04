package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.Entregado

class TestEstadoEntregado {

	// Estructura
	@Mock Pedido 			unPedidoMock
		  EstadoDePedido	unEstadoEntregadoTest
		  EstadoDePedido  	otroEstadoEntregadoTest
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoEntregadoTest		= spy(new Entregado)
		otroEstadoEntregadoTest		= new Entregado
		
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoEntregadoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoEntregadoTest		 .siguiente(unPedidoMock)
		
		// Assertion
		verify(unEstadoEntregadoTest).siguiente(unPedidoMock)
	}
	
	@Test
	def test01cuandoElEstadoEntregadoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoEntregadoTest		 .anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoEntregadoTest).anterior(unPedidoMock)
	}
	@Test
	def test02cuandoElEstadoEntregaSeLePidePrevioYEntregadoDevuelveElEstadoEntregado(){
		// Exercise
		var estadoRespuesta = new Entregado 
		
		// Assertion
		assertEquals(otroEstadoEntregadoTest.previo.class,estadoRespuesta.class)
		assertEquals(otroEstadoEntregadoTest.proximo.class,estadoRespuesta.class)
	}
}
