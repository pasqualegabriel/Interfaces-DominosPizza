package domino

import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import domino.DominoPizza
import pedido.Pedido
import domino.MenuDomino

class TestDominoPizza {
	
	// Estructura
	@Mock Pedido	   pedidoMock
		  DominoPizza  domino
	
	// SetUp
	@Before
	def void setup(){
		domino= new DominoPizza
	}
	
	// Tests
	@Test
	def test000DominoPizzaComienzaSinPedidosAbiertosYCerrados(){
		
		// Assertion
		assertTrue(domino.pedidosAbiertos.isEmpty)
		assertTrue(domino.pedidosCerrados.isEmpty)
	} 
	
	@Test
	def test001DominoPizzaComienzaConUnMenu(){
		
		// SetUp
		var unMenu = new MenuDomino
		
		// Assertion
		assertEquals(domino.menuDisponible.class, unMenu.class)
	}
	
	@Test
	def test002ADominoPizzaSeLeAgregaUnPedidoASuListaDePedidosAbiertos(){
		
		// Exercise
		domino.agregarPedido(pedidoMock)
		
		// Assertion
		assertFalse(domino.pedidosAbiertos.isEmpty)
	}
	
	@Test
	def test003CuandoDominoPizzasCierraUnPedidoSaleDeLaListaDePedidosAbiertosYEntraEnLaListaDePedidosCerrados(){
		
		// Exercise
		domino.agregarPedido	     (pedidoMock)
		domino.cerrarPedidoEntregado (pedidoMock)
		
		// Assertion
		assertTrue (domino.pedidosAbiertos.isEmpty)
		assertFalse(domino.pedidosCerrados.isEmpty)
	}
	
	
	
}
