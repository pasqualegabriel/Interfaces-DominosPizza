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
	
	DominoPizza 	domino
	@Mock Pedido	pedidoMock
	
	// SetUp
	
	@Before
	def void setup(){
		domino= new DominoPizza
	}
	
	// Tests
	
	@Test
	def test000DominoPizzaComienzaSinPedidosAbiertosYCerrados(){
		
		assertTrue(domino.pedidosAbiertos.isEmpty)
		assertTrue(domino.pedidosCerrados.isEmpty)
	} 
	
	@Test
	def test000DominoPizzaComienzaConUnMenu(){
		
		// SetUp
		
		var unMenu = new MenuDomino
		
		// Assertion
		
		assertEquals(domino.menuDisponible.class, unMenu.class)
	}
	
	@Test
	def test000ADominoPizzaSeLeAgregaUnPedidoASuListaDePedidosAbiertos(){
		
		// Exercise
		
		domino.agregarPedido(pedidoMock)
		
		// Assertion
		
		assertFalse(domino.pedidosAbiertos.isEmpty)
	}
	
	@Test
	def test000CuandoDominoPizzasCierraUnPedidoSaleDeLaListaDePedidosAbiertosYEntraEnLaListaDePedidosCerrados(){
		
		// Exercise
		
		domino.agregarPedido(pedidoMock)
		domino.cerrarPedidoEntregado (pedidoMock)
		
		// Assertion
		
		assertTrue (domino.pedidosAbiertos.isEmpty)
		assertFalse(domino.pedidosCerrados.isEmpty)
	}
	
	
	
}
