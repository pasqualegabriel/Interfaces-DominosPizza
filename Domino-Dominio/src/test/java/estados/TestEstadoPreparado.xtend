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
	
	// Estructura
	@Mock Pedido 					unPedidoMock
	@Mock Pedido 					otroPedidoMock
	@Mock Local						unaFormaDeRetiroPorLocalMock
	@Mock Delivery 					unaFormadeRetiroPorDelivyMock
	@Mock ListoParaEnviar			unEstadoListoParaRetirarMock
	@Mock ListoParaRetirar 			unEstadoListoParaEnviarMock
	  	  EstadoDePedido 			unEstadoPreparandoTest
		  EstadoDePedido			otroEstadoDePreparandoTest
	
	// Setup
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoPreparandoTest		= spy(new Preparando)
		otroEstadoDePreparandoTest	= new Preparando
		
		when(unaFormaDeRetiroPorLocalMock.avanzarEstado) .thenReturn(unEstadoListoParaRetirarMock)
		when(unaFormadeRetiroPorDelivyMock.avanzarEstado).thenReturn(unEstadoListoParaEnviarMock)
		
		
		when(unPedidoMock.formaDeRetiro)  .thenReturn(unaFormaDeRetiroPorLocalMock)
		when(otroPedidoMock.formaDeRetiro).thenReturn(unaFormadeRetiroPorDelivyMock)
		
	}
	
	// Tests
	@Test
	def test00cuandoElEstadoPrerandoLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoPreparandoTest		  .siguiente(unPedidoMock)
		verify(unEstadoPreparandoTest).siguiente(unPedidoMock)
		
		// Assertion
		unEstadoPreparandoTest	      .siguiente(otroPedidoMock)
		verify(unEstadoPreparandoTest).siguiente(otroPedidoMock)
	}
	@Test
	def test01cuandoElEstadoPrerandoLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		// Exercise
		unEstadoPreparandoTest.anterior(unPedidoMock)
		
		// Assertion
		verify(unEstadoPreparandoTest).anterior(unPedidoMock)
	}
	
	@Test
	def test02cuandoAElEstadoPreprandoSeLePidePrevioEsteTeDaElEstadoAnteriorQueEsElMismo(){
		// Setup
		var unEstadoRespuesta = new Preparando
		
		// Assertion
		assertEquals(otroEstadoDePreparandoTest.previo.class,unEstadoRespuesta.class)
	}
	
	@Test
	def test03cuandoAElEstadoPreparandoSeLePideProximoDevuelveListoParaRetirar()
	{
		var unPreparado = new Preparando
		unPreparado.unaFormaDeEnvio = unaFormaDeRetiroPorLocalMock
		
		when(unaFormaDeRetiroPorLocalMock.avanzarEstado).thenReturn(unEstadoListoParaEnviarMock)
		when(unEstadoListoParaEnviarMock.nombre).thenReturn("Listo para retirar")
		// Assertion
		assertEquals(otroEstadoDePreparandoTest.proximo.nombre,unEstadoListoParaEnviarMock.nombre)
	}
	
	
	 
}
