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
	@Mock Miembro mockMiembro 
	@Mock Comunicable mockComunicable 
	@Mock GMailSender  spyGmailSender
	
	// SetUp
	@Before
	def void setUp() {
		spyGmailSender = spy(new GMailSender("pepita", "golondrina"))
		MockitoAnnotations.initMocks(this)
		unaComunicacionPorMail = new ComunicacionPorMail
		
		
	}
	
	// Tests
	
	@Test
	def test000CuandoAComunicacionPorMailComunicaAUnUsuarioSeLeEnviaUnMailAEste(){
		
		// Exercise
		unaComunicacionPorMail.gmailsender = spyGmailSender 
	
		when(mockMiembro.mail).thenReturn("n.Autalan@Gmail.com")
		when(mockComunicable.tituloMensaje).thenReturn("Probando")
		when(mockComunicable.cuerpoMensaje).thenReturn("ACaraDePerro")
		
		unaComunicacionPorMail.comunicarUsuario(mockMiembro, mockComunicable)
		
		
	}
	
}