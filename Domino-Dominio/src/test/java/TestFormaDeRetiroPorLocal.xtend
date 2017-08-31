import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test



class TestFormaDeRetiroPorLocal {
	
	//Estructura
	FormaDeRetiro 		unRetiroPorLocalTest
	EstadoDePedido 		estadoResultado
	
	@Before
	def void SetUp(){
		unRetiroPorLocalTest	= new Local
		estadoResultado			= new ListoParaRetirar
	}
	
	@Test
	def unRetiroPporLocalTestCuandoSeLePideAvanzarEstadoRetornaElEstadoListoParaRetirar(){
		
		
		assertEquals(unRetiroPorLocalTest.avanzarEstado.class, estadoResultado.class)
	}
	 	
	
}