package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import estados.ListoParaRetirar
import pedido.Pedido
import estados.Entregado
import estados.Preparando

class TestEstadoListoParaRetirar {
	
	// Estructura
		  EstadoDePedido  unEstadoListoParaRetirarTest
		  EstadoDePedido  otroEstadoListoParaRetirarTest
	@Mock Pedido	 	  unPedidoMock
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaRetirarTest	= spy(new ListoParaRetirar)
		otroEstadoListoParaRetirarTest	= new ListoParaRetirar
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoListoParaRetirarLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoListoParaRetirarTest		.siguiente(unPedidoMock)
		
		// Assertion
		verify(unEstadoListoParaRetirarTest).siguiente(unPedidoMock)
	}
	
	@Test
	def test01cuandoElEstadoListoParaRetirarLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoListoParaRetirarTest		.anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoListoParaRetirarTest).anterior(unPedidoMock)
	}
	
	@Test
	def test02cuandoElEstadoListoParaRetirarSeLePidePrevioDevuelveElEstadoPreparando(){
		// Setup
		var estadoRespuesta = new Preparando
		
		// Assertion
		assertEquals(otroEstadoListoParaRetirarTest.previo.class,estadoRespuesta.class)
	}
	
	@Test
	def test03cuandoElEstadoListoParaRetirarSeLePideProximoDevuelveElEstadoEntregado(){
		// Setup
		var estadoRespuesta = new Entregado
		
		// Assertion
		assertEquals(otroEstadoListoParaRetirarTest.proximo.class,estadoRespuesta.class)
	}
}
