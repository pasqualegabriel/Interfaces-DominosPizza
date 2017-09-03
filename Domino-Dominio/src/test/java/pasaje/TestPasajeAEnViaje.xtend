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
	//Estructura
	PasajeEnViaje				unPasajeEnViajeTest
	@Mock Pedido 				unPedidoMock
	@Mock DominoPizza	 		unDominoPizzaMock
	@Mock Miembro		    	unMiembroMock
	
	@Before
	def void SetUp(){
		
		
		unPasajeEnViajeTest		= new PasajeEnViaje
		MockitoAnnotations.initMocks(this)
		when(unPedidoMock.miembro).thenReturn(unMiembroMock)
		
	}
	
	@Test
	def unPasajeAEnViajeConoceASuCumunicableEnViaje(){
		
		var comunicacionRespuesta = new ComunicadoParaViaje
		
		assertEquals(unPasajeEnViajeTest.comunicado.class, comunicacionRespuesta.class)
	}
	
	@Test
	def unPasajeAEnViajePuedeEjecutaParaQueElMiembroDelPedidoEnvieElComunicado(){
		
		var unComunicado = unPasajeEnViajeTest.comunicado
		
		unPasajeEnViajeTest.ejecutar(unPedidoMock, unDominoPizzaMock)
		
		verify(unMiembroMock).comunicar(unComunicado)
	}
	
}


