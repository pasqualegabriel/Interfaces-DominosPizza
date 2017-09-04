package pedido

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import pedido.FormaDeRetiro
import pedido.Local
import estados.ListoParaRetirar
import estados.EstadoDePedido

class TestFormaDeRetiroPorLocal {
	
	//Estructura
	FormaDeRetiro 		unRetiroPorLocalTest
	EstadoDePedido 		estadoResultado
	
	// SetUp 
	@Before
	def void setUp(){
		unRetiroPorLocalTest	= new Local
		estadoResultado			= new ListoParaRetirar
	}
	
	// Tests
	@Test
	def test00unRetiroPporLocalTestCuandoSeLePideAvanzarEstadoRetornaElEstadoListoParaRetirar(){
		
		// Assertion
		assertEquals(unRetiroPorLocalTest.avanzarEstado.class, estadoResultado.class)
	}
	 	
	
}
