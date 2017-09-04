package estados

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
	
	// Estructura
	@Mock Pedido 			unPedidoMock
		  EstadoDePedido	unEstadoCanceladoTest
	      EstadoDePedido  	otroEstadoCanceladoTest
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoCanceladoTest		= spy(new Cancelado)
		otroEstadoCanceladoTest		= new Cancelado
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoCanceladoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoCanceladoTest		 .siguiente(unPedidoMock)
		
		// Assertion
		verify(unEstadoCanceladoTest).siguiente(unPedidoMock)
	}
	
	@Test
	def test01cuandoElEstadoCanceladoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoCanceladoTest		 .anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoCanceladoTest).anterior(unPedidoMock)
	}
	
	@Test
	def test02cuandoElEstadoCanceladoSeLePidePrevioYEntregadoDevuelveElEstadoCancelado(){
		// Setup
		var estadoRespuesta = new Cancelado 
		
		// Assertion
		assertEquals(otroEstadoCanceladoTest.previo .class,estadoRespuesta.class)
		assertEquals(otroEstadoCanceladoTest.proximo.class,estadoRespuesta.class)
	}	
}
