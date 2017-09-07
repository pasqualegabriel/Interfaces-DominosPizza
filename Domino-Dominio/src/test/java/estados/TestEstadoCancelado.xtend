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
import domino.Miembro

class TestEstadoCancelado {
	
	// Estructura
	Pedido 				unPedidoSpy
	EstadoDePedido		unEstadoCanceladoTest
	
	@Mock Miembro		unMockMiembro
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unPedidoSpy					= spy(new Pedido(unMockMiembro))
		unEstadoCanceladoTest		= new Cancelado
		
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoCanceladoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoCanceladoTest		 .siguiente(unPedidoSpy)
		
		// Assertion
		verify(unPedidoSpy).estadoActual = unEstadoCanceladoTest.proximo
	}
	
	@Test
	def test01cuandoElEstadoCanceladoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoCanceladoTest		 .anterior(unPedidoSpy)
		
		// Assertion
		verify(unPedidoSpy).estadoActual = unEstadoCanceladoTest.previo
	}
	
	@Test
	def test02cuandoElEstadoCanceladoSeLePidePrevioYEntregadoDevuelveElEstadoCancelado(){
		// Setup
		var estadoRespuesta = new Cancelado 
		
		// Assertion
		assertEquals(unEstadoCanceladoTest.previo .class,estadoRespuesta.class)
		assertEquals(unEstadoCanceladoTest.proximo.class,estadoRespuesta.class)
	}	
}
