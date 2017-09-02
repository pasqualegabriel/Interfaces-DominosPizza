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
	PasajeEnViaje					unPasajeEnViajeTest
	@Mock Pedido 					unPedidoMock
	@Mock DominoPizza 				unDominoPizzaMock
	Miembro							unMiembroSpy
	
	@Before
	def void SetUp(){
		
		
		unPasajeEnViajeTest		= new PasajeEnViaje
		unMiembroSpy			= spy(new Miembro("1","2","3","4","5"))
		MockitoAnnotations.initMocks(this)
		when(unPedidoMock.miembro).thenReturn(unMiembroSpy)
		
		
	}
	@Test
	def unPasajeAEnViajeConoceASuCumunicableEnViaje(){
		
		var comunicacionRespuesta = new ComunicadoParaViaje
		
		assertEquals(unPasajeEnViajeTest.comunicado.class,comunicacionRespuesta.class)
	}
	
	@Test
	def unPasajeAEnViajePuedeEjecutaParaQueElMiembroDelPedidoEnvieElComunicado(){
		
		var unComunicado	=  unPasajeEnViajeTest.comunicado
		
		unPasajeEnViajeTest.ejecutar(unPedidoMock,unDominoPizzaMock)
		
		verify(unMiembroSpy).comunicar(unComunicado)
		
	}
}