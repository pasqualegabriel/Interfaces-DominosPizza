package estados

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import pedido.Pedido
import estados.EnViaje
import estados.ListoParaEnviar
import estados.Entregado

class TestEstadoEnViaje {
	//Estructura
	EstadoDePedido	unEstadoEnViajeTest
	EstadoDePedido	otroEstadoEnViajeTest
	@Mock Pedido 	unPedidoMock
	
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoEnViajeTest			= spy(new EnViaje)
		otroEstadoEnViajeTest		= new EnViaje
		
	}
	
	@Test
	def cuandoElEstadoEnViajeLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoEnViajeTest.siguiente(unPedidoMock)
		verify(unEstadoEnViajeTest).siguiente(unPedidoMock)
	}
	
	@Test
	def cuandoEstadoEnViajeLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoEnViajeTest.anterior(unPedidoMock)
		verify(unEstadoEnViajeTest).anterior(unPedidoMock)
	}
	
	@Test
	def cuandoAEstadoEnViajeSeLePideElPrevioDevuelveElEstadoListoParaEnviar(){
		var estadoRespuesta = new ListoParaEnviar
		assertEquals(otroEstadoEnViajeTest.previo.class,estadoRespuesta.class)
	}
	@Test
	def cuandoAEstadoEnViajeSeLePideElProximoDevuelveElEstadoEntregado(){
		var estadoRespuesta = new Entregado
		assertEquals(otroEstadoEnViajeTest.proximo.class,estadoRespuesta.class)
		
	}
	
	
}
