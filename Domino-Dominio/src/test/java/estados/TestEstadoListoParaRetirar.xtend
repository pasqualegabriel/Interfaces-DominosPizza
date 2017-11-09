package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.junit.Assert.*
import estados.EstadoDePedido
import estados.ListoParaRetirar
import pedido.Pedido
import estados.Entregado
import estados.Preparando
import domino.Miembro

class TestEstadoListoParaRetirar {
	
	// Estructura
	@Mock Miembro		    unMiembroMock
		  EstadoDePedido	unEstadoListoParaRetirar
		  Pedido 	        unPedido
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaRetirar = new ListoParaRetirar
		unPedido                 = new Pedido(unMiembroMock,0)
	}
	
	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualListoParaRetirarEsEstadoEntregado(){
		// Exercise
		unPedido.estadoActual = unEstadoListoParaRetirar
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Entregado")
	}
	
	@Test
	def test00ElEstadoAnteriorDeUnPedidoConEstadoActualListoParaRetirarEsEstadoPreparando(){
		// Exercise
		unPedido.estadoActual = unEstadoListoParaRetirar
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Preparando")
	}
	
	@Test
	def test02cuandoElEstadoListoParaRetirarSeLePidePrevioDevuelveElEstadoPreparando(){
		// Setup
		var estadoRespuesta = new Preparando
		
		// Assertion
		assertEquals(unEstadoListoParaRetirar.previo.class, estadoRespuesta.class)
	}
	
	@Test
	def test03cuandoElEstadoListoParaRetirarSeLePideProximoDevuelveElEstadoEntregado(){
		// Setup
		var estadoRespuesta = new Entregado
		
		// Assertion
		assertEquals(unEstadoListoParaRetirar.proximo.class, estadoRespuesta.class)
	}
}
