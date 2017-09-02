package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import pedido.Delivery
import pedido.Local
import estados.ListoParaEnviar
import estados.ListoParaRetirar
import estados.Preparando

class TestEstadoPreparado {
	
	//Estructura
	EstadoDePedido 			unEstadoPreparandoTest
	EstadoDePedido			otroEstadoDePreparandoTest
	@Mock Pedido 			unPedidoMock
	@Mock Pedido 			otroPedidoMock
	@Mock Local				unaFormaDeRetiroPorLocalMock
	@Mock Delivery 			unaFormadeRetiroPorDelivyMock
	@Mock ListoParaEnviar	unEstadoListoParaRetirarMock
	@Mock ListoParaRetirar 	unEstadoListoParaEnviarMock
	
	
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoPreparandoTest		= spy(new Preparando)
		otroEstadoDePreparandoTest	= new Preparando
		
		when(unaFormaDeRetiroPorLocalMock.avanzarEstado).thenReturn(unEstadoListoParaRetirarMock)
		when(unaFormadeRetiroPorDelivyMock.avanzarEstado).thenReturn(unEstadoListoParaEnviarMock)
		
		
		when(unPedidoMock.formaDeRetiro).thenReturn(unaFormaDeRetiroPorLocalMock)
		when(otroPedidoMock.formaDeRetiro).thenReturn(unaFormadeRetiroPorDelivyMock)
		
	}
	
	
	@Test
	def cuandoElEstadoPrerandoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		unEstadoPreparandoTest.siguiente(unPedidoMock)
		verify(unEstadoPreparandoTest).siguiente(unPedidoMock)
		
		unEstadoPreparandoTest.siguiente(otroPedidoMock)
		verify(unEstadoPreparandoTest).siguiente(otroPedidoMock)
	}
	@Test
	def cuandoElEstadoPrerandoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		unEstadoPreparandoTest.anterior(unPedidoMock)
		verify(unEstadoPreparandoTest).anterior(unPedidoMock)
	}
	
	@Test
	def cuandoAElEstadoPreprandoSeLePidePrevioEsteTeDaElEstadoAnteriorQueEsElMismo(){
		
		var unEstadoRespuesta = new Preparando
		
		assertEquals(otroEstadoDePreparandoTest.previo.class,unEstadoRespuesta.class)
	}
	
	@Test
	def cuandoAElEstadoPreparandoSeLePideProximoDevuelveNull(){
		
		assertEquals(otroEstadoDePreparandoTest.proximo,null)
	}
	
	
	 
}
