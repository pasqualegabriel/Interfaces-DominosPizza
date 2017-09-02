package domino
import static org.mockito.Mockito.* 
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import domino.DominoPizza
import pedido.Pedido
import domino.Miembro
import domino.PasajeAEntregado
import org.mockito.MockitoAnnotations
import mailSender.GMailSender

class PasajeAEntregadoTest 
{
	PasajeAEntregado unPasajeAEntregado
	@Mock DominoPizza unDomino
	@Mock Pedido unPedido
	@Mock Miembro unMiembro
	@Mock GMailSender unMailSender
	
	@Before
	def void SetUp()
	{
		MockitoAnnotations.initMocks(this)
		unPasajeAEntregado = new PasajeAEntregado()	
		GMailSender.config(unMailSender)	// Setea al gmail sender la instancia del Mock para que no se envie el mail
	}
	
	@Test
	def void Dado_Un_PasajeAEntregado_Donde_El_Pedido_No_Tardo_Mas_De_30_Minutos_Solo_Se_Cierra_El_Pedido()
	{
		//Setup
		when(unPedido.tardoMasDe30Minutos()).thenReturn(false)
		when(unPedido.miembro).thenReturn(unMiembro)	
		when(unMiembro.mail).thenReturn("flame.el22@gmail.com")
		
		//Exercise
		unPasajeAEntregado.enviar(unDomino,unPedido)
		//Test
		verify(unDomino, times(1)). cerrarPedido(unPedido)
		verify(unMailSender, times(0)).sendMail(unMiembro.mail,unPasajeAEntregado.tituloMensaje,unPasajeAEntregado.cuerpoMensaje)
	}
	
	@Test
	def void Dado_Un_PasajeAEntregado_Donde_El_Pedido_Tardo_Mas_De_30_Minutos_Manda_Un_Mail_Disculpandose_Y_Se_Cierra_El_Pedido()
	{
		//Setup
		when(unPedido.tardoMasDe30Minutos()).thenReturn(true)
		
		//GMailSender.config(unMailSender)	// Setea al gmail sender la instancia del Mock para que no se envie el mail
		when(unPedido.miembro).thenReturn(unMiembro)	
		when(unMiembro.mail).thenReturn("flame.el22@gmail.com")
		

		//Exercise
		unPasajeAEntregado.enviar(unDomino,unPedido)
		
		//Test
		verify(unDomino, times(1)). cerrarPedido(unPedido)
		verify(unMailSender, times(1)).sendMail(unMiembro.mail,unPasajeAEntregado.tituloMensaje,unPasajeAEntregado.cuerpoMensaje)
	}
	
}
				