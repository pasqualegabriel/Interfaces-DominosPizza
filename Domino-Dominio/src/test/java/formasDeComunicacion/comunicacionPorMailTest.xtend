package formasDeComunicacion


import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*
import org.mockito.Mock
import comunicables.Comunicable
import domino.Miembro
import mailSender.GMailSender
import org.mockito.Spy
import comunicables.ComunicadoParaViaje
import comunicables.ComunicadoParaEntregasTardias

class comunicacionPorMailTest {
	
	// Estructura
		  ComunicacionPorMail unaComunicacionPorMail
	@Mock Miembro     		  mockMiembro 
	@Mock Comunicable  		  mockComunicable 
	@Spy  GMailSender  		  gmailsenderMock
	
	// SetUp
	@Before
	def void setUp() {

		mockMiembro     = mock(Miembro)
	    mockComunicable = mock(ComunicadoParaViaje)
	    val gmailsender = new GMailSender("user","password")
		gmailsenderMock = spy(gmailsender)
		unaComunicacionPorMail             = new ComunicacionPorMail
		unaComunicacionPorMail.gmailsender = gmailsenderMock	
	}
	
	// Tests
	@Test
	def testCuandoAComunicacionPorMailConComunicadoParaViajeComunicaAUnUsuarioSeLeEnviaUnMailAEste(){
		// Setup
		when(mockMiembro.mail).thenReturn("mail")
		when(mockComunicable.tituloMensaje).thenReturn("Probando")
		when(mockComunicable.cuerpoMensaje).thenReturn("ACaraDePerro")
		doNothing.when(gmailsenderMock).sendMail("mail", "Probando", "ACaraDePerro")
		// Exercise
		unaComunicacionPorMail.comunicarUsuario(mockMiembro, mockComunicable)
		
		// Assertion
		verify(gmailsenderMock).sendMail("mail", "Probando", "ACaraDePerro")
	
	}

	@Test
	def testCuandoAComunicacionPorMailConComunicadoParaEntregasTardiasComunicaAUnUsuarioSeLeEnviaUnMailAEste(){
		// Setup
		mockComunicable = mock(ComunicadoParaEntregasTardias)
		when(mockMiembro.mail).thenReturn("mail")
		when(mockComunicable.tituloMensaje).thenReturn("Probando")
		when(mockComunicable.cuerpoMensaje).thenReturn("ACaraDePerro")
		doNothing.when(gmailsenderMock).sendMail("mail", "Probando", "ACaraDePerro")
		// Exercise
		unaComunicacionPorMail.comunicarUsuario(mockMiembro, mockComunicable)
		
		// Assertion
		verify(gmailsenderMock).sendMail("mail", "Probando", "ACaraDePerro")
	
	}

	
	
	
}











