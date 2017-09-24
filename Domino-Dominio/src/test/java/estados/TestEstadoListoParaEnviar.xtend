package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.ListoParaEnviar
import estados.Preparando
import estados.EnViaje
import domino.Miembro

class TestEstadoListoParaEnviar {
	
	// Estructura
	@Mock Miembro		    unMockMiembro
		  EstadoDePedido	unEstadoListoParaEnviar
		  Pedido 	        unPedido

	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaEnviar = new ListoParaEnviar
		unPedido		        = new Pedido(unMockMiembro)
	}
	
	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualListoParaEnviarEsEstadoEnViaje(){
		// Exercise
		unPedido.estadoActual = unEstadoListoParaEnviar
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "En Viaje")
	}
	
	@Test
	def test01ElEstadoAnteriorDeUnPedidoConEstadoActualListoParaEnviarEsEstadoPreparando(){
		// Exercise
		unPedido.estadoActual = unEstadoListoParaEnviar
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Preparando")
	}
	
	@Test
	def test02cuandoAlEstadoListoParaEnviarSeLePideSuPrevioDevuelveElEstadoPreparando(){
		// Exercise
		var unEstadoRespuesta = new Preparando
		
		// Assertion
		assertEquals(unEstadoListoParaEnviar.previo.class,unEstadoRespuesta.class)
	}
	
	@Test
	def test03cuandoAlEstadoLIstoParaEnviarSeLePideSuProximoDevuelveElEstadoEnViaje(){
		// Setup
		var estadoRespuesta = new EnViaje
		
		// Assertion
		assertEquals(unEstadoListoParaEnviar.proximo.class,estadoRespuesta.class)
	}
	
	
	
		
}
