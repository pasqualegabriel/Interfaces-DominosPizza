package pasaje
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import static org.mockito.Mockito.*
import pedido.Pedido
import domino.DominoPizza
import pasajes.PasajeACancelado

class TestPasajeACancelado {
	
	// Estructura
	@Mock Pedido 					unPedidoMock
		  PasajeACancelado			pasajeACanceladoTest
		  DominoPizza 				unDominoPizzaSpy
	

	// Setup
	@Before
	def void setUp(){
		pasajeACanceladoTest				= new PasajeACancelado
		unDominoPizzaSpy					= spy(new DominoPizza)
		MockitoAnnotations.initMocks(this)
		
							
	}
	
	// Tests
	@Test
	def test00elPasajeACanceladoPuedeEjecutarseYPonerUnPedidoALaListaDeCanceladosDeDominoPizza(){
		
		// Exercise
		pasajeACanceladoTest.ejecutar(unPedidoMock,unDominoPizzaSpy)
		
		// Assertion
		verify(unDominoPizzaSpy).agregarPedidosCancelados(unPedidoMock)	
		
	}

}