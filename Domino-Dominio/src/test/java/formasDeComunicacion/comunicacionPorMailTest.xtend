package formasDeComunicacion


import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import comunicables.Comunicable
import domino.Miembro
import mailSender.GMailSender

class comunicacionPorMailTest {
	
	// Estructura
	ComunicacionPorMail unaComunicacionPorMail
	@Mock Miembro       mockMiembro 
	@Mock Comunicable   mockComunicable 
	@Mock GMailSender   gmailsenderMock
	
	// SetUp
	@Before
	def void setUp() {
		MockitoAnnotations.initMocks(this)
		unaComunicacionPorMail = new ComunicacionPorMail
		unaComunicacionPorMail.gmailsender = gmailsenderMock		
		
	}
	
	// Tests
	
	@Test
	def test000CuandoAComunicacionPorMailComunicaAUnUsuarioSeLeEnviaUnMailAEste(){
		
		when(mockMiembro.mail).thenReturn("mail")
		when(mockComunicable.tituloMensaje).thenReturn("Probando")
		when(mockComunicable.cuerpoMensaje).thenReturn("ACaraDePerro")
		
		unaComunicacionPorMail.comunicarUsuario(mockMiembro, mockComunicable)
		
		verify(gmailsenderMock).sendMail("mail", "Probando", "ACaraDePerro")
	
	}
	
}