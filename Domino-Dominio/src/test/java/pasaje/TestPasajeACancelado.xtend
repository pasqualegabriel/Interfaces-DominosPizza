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
	//Estructura
	PasajeACancelado				pasajeACanceladoTest
	@Mock Pedido 					unPedidoMock
	DominoPizza 					unDominoPizzaSpy
	

	@Before
	def void SetUp(){
		
		
		pasajeACanceladoTest				= new PasajeACancelado
		unDominoPizzaSpy					= spy(new DominoPizza)
		MockitoAnnotations.initMocks(this)
		
							
	}
	
	@Test
	def elPasajeACanceladoPuedeEjecutarseYPonerUnPedidoALaListaDeCanceladosDeDominoPizza(){
		pasajeACanceladoTest.ejecutar(unPedidoMock,unDominoPizzaSpy)
		verify(unDominoPizzaSpy).agregarPedidosCancelados(unPedidoMock)	
		
	}

}