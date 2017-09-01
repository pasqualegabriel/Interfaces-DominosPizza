import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import static org.junit.Assert.*
import estados.EstadoDePedido
import estados.ListoParaRetirar
import pedido.Pedido
import estados.Entregado
import estados.Preparando

class TestEstadoListoParaRetirar {
	//Estructura
	EstadoDePedido	unEstadoListoParaRetirarTest
	EstadoDePedido  otroEstadoListoParaRetirarTest
	@Mock Pedido 	unPedidoMock
	
	@Before
	def void SetUp(){
		MockitoAnnotations.initMocks(this)
		unEstadoListoParaRetirarTest	= spy(new ListoParaRetirar)
		otroEstadoListoParaRetirarTest	= new ListoParaRetirar
	}
	
	@Test
	def cuandoElEstadoListoParaRetirarLeLLegaSiguienteSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoListoParaRetirarTest.siguiente(unPedidoMock)
		verify(unEstadoListoParaRetirarTest).siguiente(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoListoParaRetirarLeLLegaAnteriorSeVerificaQueRequestEstadoEntregaLlego(){
		
		unEstadoListoParaRetirarTest.anterior(unPedidoMock)
		verify(unEstadoListoParaRetirarTest).anterior(unPedidoMock)
	}
	
	@Test
	def cuandoElEstadoListoParaRetirarSeLePidePrevioDevuelveElEstadoPreparando(){
		var estadoRespuesta = new Preparando
		assertEquals(otroEstadoListoParaRetirarTest.previo.class,estadoRespuesta.class)
	}
	
	@Test
	def cuandoElEstadoListoParaRetirarSeLePideProximoDevuelveElEstadoEntregado(){
		var estadoRespuesta = new Entregado
		assertEquals(otroEstadoListoParaRetirarTest.proximo.class,estadoRespuesta.class)
	}
}