package pedido

import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.when;
//import static org.mockito.Matchers.anyLong;
//import static org.mockito.Matchers.thenReturn;
import org.mockito.MockitoAnnotations
//import java.time.format.DateTimeFormatter
import java.time.LocalDateTime
import pedido.Pedido
import domino.Miembro
import pedido.Plato
import estados.Cancelado
import pedido.Local
import pedido.Delivery

//import javax.swing.Timer
//import java.awt.event.ActionEvent
//import java.awt.event.ActionListener

class TestPedido {

	// Estructura
	
	Pedido 		   pedido
	@Mock Miembro  clienteMock
	@Mock Plato    unPlato
	@Mock Local    unRetiroEnElLocal
	@Mock Delivery unRetiroConDelivery	
	// SetUp 
	// Se inician los mocks y crea un pedido Hecho por un clienteMock
	
	@Before
	def void setUp() {
		MockitoAnnotations.initMocks(this)
		pedido = new Pedido(clienteMock)

	}
	
	// Tests
	
	@Test
	def test000UnPedidoTieneUnCliente() {
		
		// Exercise
		
		when(clienteMock.nombre).thenReturn("javi")
		
		// Assertion
		
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
		
		var tiempoActual= LocalDateTime.now()
		
		assertEquals(pedido.fecha.class, tiempoActual.class)
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
		
		// Assertion
		
		assertEquals(pedido.aclaracion, aclaracionTest)
	}

	@Test
	def test007SeLeAgregaUnPlatoAlPedido() {
		
		// Exercise
		
		pedido.agregarPlato(unPlato)
		
		// Assertion
		
		assertEquals(pedido.platos.size, 1)
		assertFalse(pedido.platos.empty)
	}

	@Test
	def test008SeLeQuitaUnPlatoAlPedido() {
		
		// Exercise
		
		pedido.agregarPlato(unPlato)
		pedido.quitarPlato(unPlato)

		// Assertion
		
		assertEquals(pedido.platos.size, 0)
		assertTrue(pedido.platos.empty)

	}

	@Test
	def test009UnPedidoCalculaCalculaSuPrecio() {
		
		//Setup
		var precioPedido = 0
		// Exercise
		pedido.formaDeRetiro = unRetiroEnElLocal
		pedido.agregarPlato(unPlato)
		when(unPlato.calcularPrecio).thenReturn(100 /*pesos*/ )
		when(unRetiroEnElLocal.precioDeRetiro).thenReturn(0 /*pesos*/ )
		precioPedido = pedido.calcularPrecio
		
		// Assertion
		
		assertEquals(pedido.platos.size, 1)
		assertEquals(100,precioPedido)
	}

	@Test
	def test009UnPedidoPuedeCancelarse() {
		
		// SetUp
		
		var cancelado = new Cancelado

		// Exercise
		
		pedido.cancelar()

		// Assertion
		
		assertEquals(pedido.estadoActual.class, cancelado.class)
	}

	@Test
	def test010SiAUnPedidoQueTieneMasDe30MinutosDeDemoraSeLePReguntaSiTardoMasDe30MinutosDaTrue()
	{
		val treintaMinitosDespues = LocalDateTime.now.plusMinutes(31)
		pedido.fecha = treintaMinitosDespues
		//Exercise
		//Test
		assertTrue(pedido.tardoMasDe30Minutos)
	}
	
	@Test
	def test011SiAUnPedidoQueTieneMenosDe30MinutosDeDemoraSeLePReguntaSiTardoMasDe30MinutosDaFalse()
	{
		//Setup
		var horaActual = LocalDateTime.now
		pedido.fecha = horaActual
		//Exercise
		//Test
		assertFalse(pedido.tardoMasDe30Minutos)
	}
	
	@Test
	def test012UnPedidoConDeliveryCalculaSuPrecio() {
		
		//Setup
		var precioPedido = 0
		// Exercise
		pedido.formaDeRetiro = unRetiroConDelivery
		pedido.agregarPlato(unPlato)
		when(unPlato.calcularPrecio).thenReturn(100 /*pesos*/ )
		when(unRetiroConDelivery.precioDeRetiro).thenReturn(15 /*pesos*/ )
		precioPedido = pedido.calcularPrecio
		
		// Assertion
		
		assertEquals(pedido.platos.size, 1)
		assertEquals(115,precioPedido)
	}
}

