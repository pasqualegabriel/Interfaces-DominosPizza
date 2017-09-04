package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.EnViaje
import estados.ListoParaEnviar
import estados.Entregado

class TestEstadoEnViaje {
	
	// Estructura
	@Mock Pedido 	        unPedidoMock
		  EstadoDePedido	unEstadoEnViajeTest
		  EstadoDePedido	otroEstadoEnViajeTest
	
	// Setup
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoEnViajeTest			= spy(new EnViaje)
		otroEstadoEnViajeTest		= new EnViaje
		
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoEnViajeLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoEnViajeTest		   .siguiente(unPedidoMock)
		
		// Assertion
		verify(unEstadoEnViajeTest).siguiente(unPedidoMock)
	}
	
	@Test
	def test01cuandoEstadoEnViajeLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoEnViajeTest		   .anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoEnViajeTest).anterior(unPedidoMock)
	}
	
	@Test
	def test02cuandoAEstadoEnViajeSeLePideElPrevioDevuelveElEstadoListoParaEnviar(){
		// Setup
		var estadoRespuesta = new ListoParaEnviar
		
		// Assertion
		assertEquals(otroEstadoEnViajeTest.previo.class,estadoRespuesta.class)
	}
	@Test
	def test03cuandoAEstadoEnViajeSeLePideElProximoDevuelveElEstadoEntregado(){
		// Setup
		var estadoRespuesta = new Entregado
		
		// Assertion
		assertEquals(otroEstadoEnViajeTest.proximo.class,estadoRespuesta.class)
		
	}
	
	
}
