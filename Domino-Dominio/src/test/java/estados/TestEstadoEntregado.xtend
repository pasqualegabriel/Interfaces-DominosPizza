package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.Entregado
import domino.Miembro

class TestEstadoEntregado {

	// Estructura
	@Mock Miembro			unMiembroMock 
		  Pedido 			unPedidoMock
		  EstadoDePedido	unEstadoEntregadoTest
		  EstadoDePedido  	otroEstadoEntregadoTest
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unPedidoMock                = new Pedido(unMiembroMock)
		unEstadoEntregadoTest		= new Entregado
		otroEstadoEntregadoTest		= new Entregado
		
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoEntregadoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unPedidoMock.estadoActual = otroEstadoEntregadoTest
		unEstadoEntregadoTest.siguiente(unPedidoMock)
		
		// Assertion
		assertEquals(unPedidoMock.estadoActual.nombre, "Entregado")
	}
	
	@Test
	def test01cuandoElEstadoEntregadoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unPedidoMock.estadoActual = otroEstadoEntregadoTest
		unEstadoEntregadoTest.anterior(unPedidoMock)
		
		// Assertion
		assertEquals(unPedidoMock.estadoActual.nombre, "Entregado")
	}
	@Test
	def test02cuandoElEstadoEntregaSeLePidePrevioYProximoDevuelveElEstadoEntregado(){
		// Exercise
		var estadoRespuesta = new Entregado 
		
		// Assertion
		assertEquals(unEstadoEntregadoTest.previo.class,estadoRespuesta.class)
		assertEquals(unEstadoEntregadoTest.proximo.class,estadoRespuesta.class)
	}
}
