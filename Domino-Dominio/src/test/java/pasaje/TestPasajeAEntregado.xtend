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
	//Estructura
	PasajeAEntregado				pasajeAEntregadoTest
	@Mock Pedido 					unPedidoMock
	DominoPizza 					unDominoPizzaSpy
	Miembro							unMiembroSpy
	
	@Before
	def void SetUp(){
		
		
		pasajeAEntregadoTest				= new PasajeAEntregado
		unMiembroSpy						= spy(new Miembro("1","2","3","4","5"))
		unDominoPizzaSpy					= spy(new DominoPizza)
		MockitoAnnotations.initMocks(this)
		when(unPedidoMock.miembro).thenReturn(unMiembroSpy)
		
							
	}
	
	@Test
	def unPasajeAEntregadoConoceASuCumunicadoParaEntregado(){
		var unComunidacoRespuesta= new ComunicadoParaEntregasTardias
		
		assertEquals(pasajeAEntregadoTest.comunicado.class,unComunidacoRespuesta.class)
		
	}
	@Test
	def unPasajeAEntregadoSabeEjecutarseParaQueAlMiembroDelPedidoLeLLegueUnMailEnCasoQueHayanPasado30MinYParaQueDominoCierreUnPedidoEntregado(){
		var unComunicadoParaElMiembro	= pasajeAEntregadoTest.comunicado
		
		when(unPedidoMock.tardoMasDe30Minutos).thenReturn(true)
		pasajeAEntregadoTest.ejecutar(unPedidoMock,unDominoPizzaSpy)
		verify(unMiembroSpy).comunicar(unComunicadoParaElMiembro)
		verify(unDominoPizzaSpy).cerrarPedidoEntregado(unPedidoMock)
		
	}
	/* 
	@Test
	def unPasajeAEntregadoSabeEjecutarseParaQueAlMiembroNoleLLegeUnMailPorqueNoPaso30MinYParaQueDominoCierreUnPedidoEntregado(){
		var unComunicadoParaElMiembro	= pasajeAEntregadoTest.comunicado
		
		when(unPedidoMock.tardoMasDe30Minutos).thenReturn(false)
		pasajeAEntregadoTest.ejecutar(unPedidoMock,unDominoPizzaSpy)
	 	(unMiembroSpy).comunicar(unComunicadoParaElMiembro)
		
		verify(unDominoPizzaSpy).cerrarPedidoEntregado(unPedidoMock)
		
		
		
	} */
	
	
	
	
}