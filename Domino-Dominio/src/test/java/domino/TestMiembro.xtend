package domino


import formasDeComunicacion.ComunicacionPorMail
import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import pedido.Pedido

import static org.junit.Assert.*
import comunicables.Comunicable

class TestMiembro {

	// Estructura
	@Mock Pedido 				pedidoMock
	@Mock Comunicable 			comunicableMock
	@Mock ComunicacionPorMail 	comunicacionPorMailMock
		  Miembro 				usuarioPepita
	
	// SetUp
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
	
	@Test
	def test000SeEnviaUnMensajeAlUsuario() {
		// Exercise
		usuarioPepita.formaDeComunicacion = comunicacionPorMailMock
		usuarioPepita.comunicar(comunicableMock) 
		
		// Assertion
		verify(comunicacionPorMailMock).comunicarUsuario(usuarioPepita,comunicableMock)
	}
}
