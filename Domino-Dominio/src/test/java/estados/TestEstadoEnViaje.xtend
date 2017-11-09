package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.EnViaje
import estados.ListoParaEnviar
import estados.Entregado
import domino.Miembro

class TestEstadoEnViaje {
	
	// Estructura
	@Mock Miembro		 unMockMiembro
		  EstadoDePedido unEstadoEnViaje
		  Pedido 		 unPedido
	
	// Setup
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoEnViaje	= new EnViaje
		unPedido		= new Pedido(unMockMiembro,0)
	}
	
	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualEnViajeEsEstadoEntregado(){
		// Exercise
		unPedido.estadoActual = unEstadoEnViaje
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Entregado")
	}
	
	@Test
	def test01ElEstadoAnteriorDeUnPedidoConEstadoActualEnViajeEsEstadoListoParaEnviar(){
		// Exercise
		unPedido.estadoActual = unEstadoEnViaje
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Listo para enviar")
	}
	
	@Test
	def test02cuandoAEstadoEnViajeSeLePideElPrevioDevuelveElEstadoListoParaEnviar(){
		// Setup
		var estadoRespuesta = new ListoParaEnviar
		
		// Assertion
		assertEquals(unEstadoEnViaje.previo.class, estadoRespuesta.class)
	}
	@Test
	def test03cuandoAEstadoEnViajeSeLePideElProximoDevuelveElEstadoEntregado(){
		// Setup
		var estadoRespuesta = new Entregado
		
		// Assertion
		assertEquals(unEstadoEnViaje.proximo.class, estadoRespuesta.class)
		
	}
	
	
}
