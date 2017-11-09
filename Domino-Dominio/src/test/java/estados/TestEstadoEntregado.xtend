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
		  Pedido 			unPedido
		  EstadoDePedido	unEstadoEntregado
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unPedido                = new Pedido(unMiembroMock,0)
		unEstadoEntregado		= new Entregado
		
	}
	
	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualEntregadoSigueSiendoEntregado(){
		// Exercise
		unPedido.estadoActual = unEstadoEntregado
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Entregado")
	}
	
	@Test
	def test02ElEstadoAnteriorDeUnPedidoConEstadoActualEntregadoSigueSiendoEntregado(){
		// Exercise
		unPedido.estadoActual = unEstadoEntregado
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Entregado")
	}
	@Test
	def test02cuandoElEstadoEntregaSeLePidePrevioYProximoDevuelveEstadoEntregado(){
		// Exercise
		var estadoRespuesta = new Entregado 
		
		// Assertion
		assertEquals(unEstadoEntregado.previo.class,  estadoRespuesta.class)
		assertEquals(unEstadoEntregado.proximo.class, estadoRespuesta.class)
	}
}
