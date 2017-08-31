import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.when;
//import static org.mockito.Matchers.anyLong;
//import static org.mockito.Matchers.thenReturn;
import org.mockito.MockitoAnnotations
import java.time.format.DateTimeFormatter
import java.time.LocalDateTime
//import javax.swing.Timer
//import java.awt.event.ActionEvent
//import java.awt.event.ActionListener

class TestPedido {

	Pedido pedido
	@Mock Miembro cliente
	@Mock Plato unPlato

	@Before
	def void setUp() {
		MockitoAnnotations.initMocks(this)
		when(cliente.nombre).thenReturn("javi")
		pedido = new Pedido(cliente)

	}

	@Test
	def test000UnPedidoTieneUnCliente() {
		assertEquals(pedido.miembro.nombre, "javi")

	}

	@Test
	def test001UnPedidoComienzaEnEstadoPreparando() {

		assertEquals(pedido.estadoActual.nombre, "Preparando")
	}

	@Test
	def test002UnPedidoComienzaSinPlatos() {

		assertTrue(pedido.platos.isEmpty())
	}

	@Test
	def test003UnPedidoComienzaConUnaFechaYHora() {

		var dateformat = DateTimeFormatter.ofPattern("yyy/MM/dd HH:mm:ss")
		var now = LocalDateTime.now()
		var ahora = dateformat.format(now)

		assertEquals(pedido.fecha, ahora)
	}

	@Test
	def test004UnPedidoComienzaConUnMontoAPagarDeCeroPesos() {
		assertEquals(pedido.montoAPagar, 0 /*Pesos*/ )
	}

	@Test
	def test005UnPedidoComienzaSinAclaracion() {
		assertTrue(pedido.aclaracion.isEmpty())
	}

	@Test
	def test006UnPedidoSeLeCambiaLaAclaracionATardoMucho() {
		// Exercise
		var aclaracionTest = "Tardo Mucho"
		pedido.cambiarAclaracion(aclaracionTest)
		assertEquals(pedido.aclaracion, aclaracionTest)
	}

	@Test
	def test007SeLeAgregaUnPlatoAlPedido() {
		// Exercise
		pedido.agregarPlato(unPlato)

		assertEquals(pedido.platos.size, 1)
		assertFalse(pedido.platos.empty)
	}

	@Test
	def test008SeLeQuitaUnPlatoAlPedido() {
		// Exercise
		pedido.agregarPlato(unPlato)

		assertEquals(pedido.platos.size, 1)
		assertFalse(pedido.platos.empty)

		pedido.quitarPlato(unPlato)

		assertEquals(pedido.platos.size, 0)
		assertTrue(pedido.platos.empty)

	}

	@Test
	def test009UnPedidoCalculaCalculaSuPrecio() {
		// Exercise
		pedido.agregarPlato(unPlato)
		when(unPlato.calcularPrecio).thenReturn(100 /*pesos*/ )
		pedido.calcularPrecio
		assertEquals(pedido.platos.size, 1)
	}

	@Test
	def test009UnPedidoPuedeCancelarse() {
		var cancelado = new Cancelado

		// Exercise
		pedido.cancelar()

		assertEquals(pedido.estadoActual.class, cancelado.class)
	}
/* 
	@Test
	def test00CuandoUnPedidoLLevaCreado30minutosEnviaUnMailAlUsuarioPidiendoleDisculpasPorLaDemora() {
		var unMinuto = 60000
		var treintaMinutos = unMinuto * 30

		var Timer timer = new Timer(100, new ActionListener() {
			@Override
			override void actionPerformed(ActionEvent arg0) {
				//Acion a ejecutar
			}
		});
		timer.setRepeats(false); // Only execute once
		timer.start(); // Go go go!
		
	}
	

// Falta lo del tiempo y confirmar!!!
*/
}
