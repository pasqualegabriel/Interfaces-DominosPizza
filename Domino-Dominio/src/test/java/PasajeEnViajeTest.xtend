
import static org.mockito.Mockito.*
import org.junit.Before
import org.junit.Test
import mailSender.GMailSender
import org.mockito.Mock
import domino.Miembro
import org.mockito.MockitoAnnotations
import domino.PasajeEnViaje
import domino.DominoPizza
import pedido.Pedido

class PasajeEnViajeTest 
{
	PasajeEnViaje unPasajeEnViaje
	@Mock GMailSender unMailSender
	@Mock Miembro unMiembro
	@Mock Pedido unPedido
	@Mock DominoPizza unDomino

	@Before
	def void SetUp()
	{
		MockitoAnnotations.initMocks(this)
		unPasajeEnViaje = new PasajeEnViaje()
	}
	
	@Test
	def Si_Un_Pedido_Pasa_A_Estado_En_Viaje_Le_Manda_Un_Mail_Al_Cliente()
	{
		//Setup
		GMailSender.config(unMailSender)	// Setea al gmail sender la instancia del Mock para que no se envie el mail
		when(unPedido.miembro).thenReturn(unMiembro)	
		when(unMiembro.mail).thenReturn("flame.el22@gmail.com")
		//Exercise
		unPasajeEnViaje.enviar(unDomino,unPedido)
		//Test
		verify(unMailSender, times(1)).sendMail(unMiembro.mail,unPasajeEnViaje.tituloMensaje,unPasajeEnViaje.cuerpoMensaje)
	} 
	
}