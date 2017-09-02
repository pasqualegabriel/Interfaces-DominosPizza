package domino

import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import pedido.Pedido
import domino.Miembro

class TestMiembro {

	// Estructura
	
	@Mock Pedido 	pedidoMock
	Miembro 		usuarioPepita
	
	// SetUp
	// Se crea el usuario con informacion predefinida y se inicia el mock
	
	@Before
	def void setUp() {
		
		MockitoAnnotations.initMocks(this)
		usuarioPepita = new Miembro("Pepita", "GolondrinaMensajera", "123", 
									"pepitaLaGolondrina@gmail.com",
									"BuenosAires CapitalFederal Brazil502 6B")
	}
	
	// Tests
	
	@Test
	def test000UnUsuarioSeCreaSinPedidosEnSuHistorial() {
		assertTrue(usuarioPepita.historialDePedidos.isEmpty)
	}

	@Test
	def test000SeAgregaUnPedidoAlHistorialDelUsuariol() {
		
		// Exercise
		
		usuarioPepita.agregarPedido(pedidoMock) 
		
		// Assertion
		
		assertFalse(usuarioPepita.historialDePedidos.isEmpty)
	}
}
