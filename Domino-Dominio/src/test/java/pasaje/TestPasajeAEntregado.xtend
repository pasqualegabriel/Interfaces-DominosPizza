package pasaje

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import pedido.Pedido
import domino.DominoPizza
import domino.Miembro
import comunicables.ComunicadoParaEntregasTardias
import pasajes.PasajeAEntregado

class TestPasajeAEntregado {
	
	// Estructura
		  PasajeAEntregado  pasajeAEntregadoTest
	      DominoPizza 	    unDominoPizzaSpy
	@Mock Miembro	        unMiembroMock
	@Mock Pedido 	        unPedidoMock
	
	// Setup
	@Before
	def void setUp(){
		pasajeAEntregadoTest = new PasajeAEntregado
		unDominoPizzaSpy	 = spy(new DominoPizza)
		MockitoAnnotations.initMocks(this)
		when(unPedidoMock.miembro).thenReturn(unMiembroMock)
				
	}
	
	// Tests
	@Test
	def test00unPasajeAEntregadoConoceASuCumunicadoParaEntregado(){
		// Setup
		var unComunidacoRespuesta= new ComunicadoParaEntregasTardias
		
		// Assertion
		assertEquals(pasajeAEntregadoTest.comunicado.class, unComunidacoRespuesta.class)
		
	}
	@Test
	def test01unPasajeAEntregadoSabeEjecutarseParaQueAlMiembroDelPedidoLeLLegueUnMailEnCasoQueHayanPasado30MinYParaQueDominoCierreUnPedidoEntregado(){
		// Setup
		var unComunicadoParaElMiembro	= pasajeAEntregadoTest.comunicado
		
		// Exercise
		when(unPedidoMock.tardoMasDe30Minutos).thenReturn(true)
		pasajeAEntregadoTest.ejecutar(unPedidoMock, unDominoPizzaSpy)
		
		// Assertion
		verify(unMiembroMock).comunicar(unComunicadoParaElMiembro)
		verify(unDominoPizzaSpy).cerrarPedidoEntregado(unPedidoMock)
		
	}

	@Test
	def test02unPasajeAEntregadoSabeEjecutarseParaQueAlMiembroNoleLLegeUnMailPorqueNoPaso30MinYParaQueDominoCierreUnPedidoEntregado(){
		// Setup
		var unComunicadoParaElMiembro	= pasajeAEntregadoTest.comunicado
		
		// Exercise
		when(unPedidoMock.tardoMasDe30Minutos).thenReturn(false)
		pasajeAEntregadoTest.ejecutar(unPedidoMock, unDominoPizzaSpy)
	
		// Assertion
	 	verify(unMiembroMock, times(0)).comunicar(unComunicadoParaElMiembro)
		verify(unDominoPizzaSpy).cerrarPedidoEntregado(unPedidoMock)

	} 
	
	
	
	
}