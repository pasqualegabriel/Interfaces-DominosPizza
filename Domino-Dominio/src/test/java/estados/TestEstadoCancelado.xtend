package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.Cancelado
import domino.Miembro

class TestEstadoCancelado {
	
	// Estructura
	Pedido 				unPedido
	EstadoDePedido		unEstadoCancelado
	
	@Mock Miembro		unMockMiembro
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unPedido		  = new Pedido(unMockMiembro)
		unEstadoCancelado = new Cancelado
		
	}
	
	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualCanceladoSigueSiendoCancelado(){
		// Exercise
		unPedido.estadoActual = unEstadoCancelado
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Cancelado")
	}
	
	@Test
	def test01ElEstadoAnteriorDeUnPedidoConEstadoActualCanceladoSigueSiendoCancelado(){
		// Exercise
		unPedido.estadoActual = unEstadoCancelado
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Cancelado")
	}
	
	@Test
	def test02cuandoElEstadoCanceladoSeLePidePrevioYProximoDevuelveEstadoCancelado(){
		// Setup
		var estadoRespuesta = new Cancelado 
		
		// Assertion
		assertEquals(unEstadoCancelado.previo .class, estadoRespuesta.class)
		assertEquals(unEstadoCancelado.proximo.class, estadoRespuesta.class)
	}	
}
