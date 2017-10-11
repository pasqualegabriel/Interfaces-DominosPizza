package pedido

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import pedido.FormaDeRetiro
import estados.EstadoDePedido
import pedido.Delivery
import estados.ListoParaEnviar

class TesFormaDeRetiroPorDelivery {
	
	//Estructura
	FormaDeRetiro 	unRetiroPorDeliveryTest
	EstadoDePedido 	estadoResultado
	
	// SetUp 
	@Before
	def void setUp(){
		unRetiroPorDeliveryTest	= new Delivery ("No Necesita")
		estadoResultado 		= new ListoParaEnviar 
	}
	
	// Tests
	@Test
	def test00unRetiroPorDeliveryTestSiSeLePideAvanzarEstadoEsteRetornaUnEstadoListoParaEnviar(){
		
		// Assertion
		assertEquals(unRetiroPorDeliveryTest.avanzarEstado.class,estadoResultado.class)
	}
}
