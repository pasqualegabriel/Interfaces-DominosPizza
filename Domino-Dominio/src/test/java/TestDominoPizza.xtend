import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock



class TestDominoPizza {
	
	//Estructura
	DominoPizza domino
	@Mock Pedido pedidoMock
	
	@Before
	def void setup(){
		domino= new DominoPizza
	}
	
	@Test
	def test000DominoPizzaComienzaSinPedidosAbiertosYCerrados(){
		assertTrue(domino.pedidosAbiertos.isEmpty)
		assertTrue(domino.pedidosCerrados.isEmpty)
	} 
	
	@Test
	def test000DominoPizzaComienzaConUnMenu(){
		
		var unMenu = new MenuDomino
		
		assertEquals(domino.menuDisponible.class, unMenu.class)
	}
	
	@Test
	def test000ADominoPizzaSeLeAgregaUnPedidoASuListaDePedidosAbiertos(){
		//excercise
		domino.agregarPedido(pedidoMock)
		
		assertFalse(domino.pedidosAbiertos.isEmpty)
	}
	
	@Test
	def test000CuandoDominoPizzasCierraUnPedidoSaleDeLaListaDePedidosAbiertosYEntraEnLaListaDePedidosCerrados(){
		//excercise
		domino.agregarPedido(pedidoMock)
		domino.cerrarPedido(pedidoMock)
		
		assertTrue(domino.pedidosAbiertos.isEmpty)
		assertFalse(domino.pedidosCerrados.isEmpty)
	}
	
	
	
}