package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
//import static org.mockito.Mockito.*
import static org.junit.Assert.*
import pedido.Pedido
import pedido.Delivery
import pedido.Local
import estados.Preparando
import domino.Miembro
import pedido.FormaDeRetiro

class TestEstadoPreparado {

	// Estructura
	@Mock Miembro		    unMiembroMock
		  Preparando    	unEstadoPreparado
		  Pedido 	        unPedido
		  FormaDeRetiro     unaFormaDeRetiroPorLocal
		  FormaDeRetiro     unaFormadeRetiroPorDelivery
	
	// Setup
	@Before
	def void setUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoPreparado           = new Preparando
		unPedido                    = new Pedido(unMiembroMock)
		unaFormaDeRetiroPorLocal    = new Local
		unaFormadeRetiroPorDelivery = new Delivery ("No necesita")
	}

	// Tests
	@Test
	def test00ElSiguienteEstadoDeUnPedidoConEstadoActualPreparadoYFormaDeRetiroPorLocalEsEstadoListoParaRetirar(){
		// Exercise
		unPedido.formaDeRetiro = unaFormaDeRetiroPorLocal
		unPedido.estadoActual  = unEstadoPreparado
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Listo para retirar")
	}
	
	@Test
	def test01ElSiguienteEstadoDeUnPedidoConEstadoActualPreparadoYFormaDeRetiroPorDeliveryEsEstadoListoParaEnviar(){
		// Exercise
		unPedido.formaDeRetiro = unaFormadeRetiroPorDelivery
		unPedido.estadoActual  = unEstadoPreparado
		unPedido.siguiente
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Listo para enviar")
	}
	
	@Test
	def test02ElEstadoAnteriorDeUnPedidoConEstadoActualPreparadoYFormaDeRetiroPorLocalSigueSiendoPreparando(){
		// Exercise
		unPedido.formaDeRetiro = unaFormaDeRetiroPorLocal
		unPedido.estadoActual  = unEstadoPreparado
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Preparando")
	}
	
	@Test
	def test03ElEstadoAnteriorDeUnPedidoConEstadoActualPreparadoYFormaDeRetiroPorDeliverySigueSiendoPreparando(){
		// Exercise
		unPedido.formaDeRetiro = unaFormadeRetiroPorDelivery
		unPedido.estadoActual  = unEstadoPreparado
		unPedido.anterior
		
		// Assertion
		assertEquals(unPedido.estadoActual.nombre, "Preparando")
	}

	@Test
	def test04cuandoAElEstadoPreprandoSeLePidePrevioEsteTeDaElEstadoAnteriorQueEsElMismo() {
		
		var unEstadoRespuesta = new Preparando

		// Assertion
		assertEquals(unEstadoPreparado.previo.class, unEstadoRespuesta.class)
	}

	@Test
	def test05cuandoAElEstadoPreparandoConFormaDeRetiroPorDeliverySeLePideProximoDevuelveListoParaEnviar() {
		
		unEstadoPreparado.formaDeRetiro = unaFormadeRetiroPorDelivery
		var unEstadoRespuesta = new ListoParaEnviar
        
        // Assertion
		assertEquals(unEstadoPreparado.proximo.class, unEstadoRespuesta.class)
	}
	
		@Test
	def test06cuandoAElEstadoPreparandoConFormaDeRetiroPorLocalSeLePideProximoDevuelveListoParaRetirar() {
		
		unEstadoPreparado.formaDeRetiro = unaFormaDeRetiroPorLocal
		var unEstadoRespuesta = new ListoParaRetirar
        
        // Assertion
		assertEquals(unEstadoPreparado.proximo.class, unEstadoRespuesta.class)
	}

}
