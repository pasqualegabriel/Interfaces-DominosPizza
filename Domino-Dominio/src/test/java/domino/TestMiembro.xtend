package domino


import formasDeComunicacion.ComunicacionPorMail
import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import pedido.Pedido

import static org.junit.Assert.*


class TestMiembro {

	// Estructura
	
	@Mock Pedido 	pedidoMock
	ComunicacionPorMail comunicacionPorMailSpy
	Miembro 		usuarioPepita
	
	// SetUp
	// Se crea el usuario con informacion predefinida y se inicia el mock
	
	@Before
	def void setUp() {
		comunicacionPorMailSpy = spy(new ComunicacionPorMail)
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
	/* No se me ocurre como testear que intenta mandar el mail sin que ejecute el codigo de adentro realmente.
	@Test
	def test000SeEnviaUnMensajeAlUsuario() {
		
		// Exercise
		
		usuarioPepita.formaDeComunicacion = comunicacionPorMailSpy
		usuarioPepita.comunicar(comunicableMock) 
		
		// Assertion
		
		verify(comunicacionPorMailSpy).comunicarUsuario(usuarioPepita,comunicableMock)
	}
	 */
}
