package pasaje
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import pedido.Pedido
import domino.DominoPizza
import comunicables.ComunicadoParaViaje
import pasajes.PasajeEnViaje
import domino.Miembro

class TestPasajeAEnViaje {
	
	// Estructura
		  PasajeEnViaje			unPasajeEnViajeTest
	@Mock Pedido 				unPedidoMock
	@Mock DominoPizza	 		unDominoPizzaMock
	@Mock Miembro		    	unMiembroMock
	
	// SetUp
	@Before
	def void setUp(){
		unPasajeEnViajeTest		= new PasajeEnViaje
		MockitoAnnotations.initMocks(this)
		when(unPedidoMock.miembro).thenReturn(unMiembroMock)
		
	}
	
	// Tests
	@Test
	def test00unPasajeAEnViajeConoceASuCumunicableEnViaje(){
		// Setup
		var comunicacionRespuesta = new ComunicadoParaViaje
		
		// Assertion
		assertEquals(unPasajeEnViajeTest.comunicado.class, comunicacionRespuesta.class)
	}
	
	@Test
	def test01unPasajeAEnViajePuedeEjecutaParaQueElMiembroDelPedidoEnvieElComunicado(){
		
		// Setup
		var unComunicado = unPasajeEnViajeTest.comunicado
		
		// Exercise
		unPasajeEnViajeTest.ejecutar(unPedidoMock, unDominoPizzaMock)
		
		// Assertion
		verify(unMiembroMock).comunicar(unComunicado)
	}
	
}


