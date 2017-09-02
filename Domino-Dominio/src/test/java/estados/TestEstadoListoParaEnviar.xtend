package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.ListoParaEnviar
import estados.Preparando
import estados.EnViaje

class TestEstadoListoParaEnviar {
	
	//Estructura
	EstadoDePedido	unEstadoListoParaEnviarTest
	EstadoDePedido	otroEstadoListoParaEnviarTest
	@Mock Pedido 	unPedidoMock
	
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaEnviarTest		= spy(new ListoParaEnviar)
		otroEstadoListoParaEnviarTest	= new ListoParaEnviar 
	}
	
	@Test
	def cuandoElEstadoListoParaEnviarLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoListoParaEnviarTest.siguiente(unPedidoMock)
		verify(unEstadoListoParaEnviarTest).siguiente(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoListoParaEnviarLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoListoParaEnviarTest.anterior(unPedidoMock)
		verify(unEstadoListoParaEnviarTest).anterior(unPedidoMock)
	}
	
	@Test
	def cuandoAlEstadoListoParaEnviarSeLePideSuPrevioDevuelveElEstadoPreparando(){
		var unEstadoRespuesta	= new Preparando
		
		assertEquals(otroEstadoListoParaEnviarTest.previo.class,unEstadoRespuesta.class)
	}
	
	@Test
	def cuandoAlEstadoLIstoParaEnviarSeLePideSuProximoDevuelveElEstadoEnViaje(){
		var estadoRespuesta = new EnViaje
		assertEquals(otroEstadoListoParaEnviarTest.proximo.class,estadoRespuesta.class)
	}
	
	
	
		
}
