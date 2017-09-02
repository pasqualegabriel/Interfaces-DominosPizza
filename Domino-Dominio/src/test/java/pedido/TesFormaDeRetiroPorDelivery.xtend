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
	
	@Before
	def void SetUp(){
		unRetiroPorDeliveryTest	= new Delivery
		estadoResultado 		= new ListoParaEnviar 
	}
	
	@Test
	def unRetiroPorDeliveryTestSiSeLePideAvanzarEstadoEsteRetornaUnEstadoListoParaEnviar(){
		 
		assertEquals(unRetiroPorDeliveryTest.avanzarEstado.class,estadoResultado.class)
	}
}
