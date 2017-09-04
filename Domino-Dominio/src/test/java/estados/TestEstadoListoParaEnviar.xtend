package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.ListoParaEnviar
import estados.Preparando
import estados.EnViaje

class TestEstadoListoParaEnviar {
	
	// Estructura
	@Mock Pedido		 	unPedidoMock
		  EstadoDePedido	unEstadoListoParaEnviarTest
		  EstadoDePedido	otroEstadoListoParaEnviarTest

	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaEnviarTest		= spy(new ListoParaEnviar)
		otroEstadoListoParaEnviarTest	= new ListoParaEnviar 
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoListoParaEnviarLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoListoParaEnviarTest        .siguiente(unPedidoMock)
		
		// Assertion
		verify(unEstadoListoParaEnviarTest).siguiente(unPedidoMock)
	}
	
	@Test
	def test01cuandoElEstadoListoParaEnviarLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoListoParaEnviarTest        .anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoListoParaEnviarTest).anterior(unPedidoMock)
	}
	
	@Test
	def test02cuandoAlEstadoListoParaEnviarSeLePideSuPrevioDevuelveElEstadoPreparando(){
		// Exercise
		var unEstadoRespuesta	= new Preparando
		
		// Assertion
		assertEquals(otroEstadoListoParaEnviarTest.previo.class,unEstadoRespuesta.class)
	}
	
	@Test
	def test03cuandoAlEstadoLIstoParaEnviarSeLePideSuProximoDevuelveElEstadoEnViaje(){
		// Setup
		var estadoRespuesta = new EnViaje
		
		// Assertion
		assertEquals(otroEstadoListoParaEnviarTest.proximo.class,estadoRespuesta.class)
	}
	
	
	
		
}
