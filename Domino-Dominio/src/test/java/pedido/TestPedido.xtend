package pedido

import org.junit.Test
import static org.junit.Assert.*
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations
import java.time.LocalDateTime
import pedido.Pedido
import domino.Miembro
import pedido.Plato
import estados.Cancelado
import pedido.Local
import pedido.Delivery



class TestPedido {

	// Estructura
	      Pedido   pedido
	@Mock Miembro  clienteMock
	@Mock Plato    unPlato
	@Mock Local    unRetiroEnElLocal
	@Mock Delivery unRetiroConDelivery	
	
	// SetUp 
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
	def test004UnPedidoComienzaSinAclaracion() {
		
		assertTrue(pedido.aclaracion.isEmpty())
	}

	@Test
	def test005UnPedidoSeLeCambiaLaAclaracionATardoMucho() {
		
		// Exercise
		var aclaracionTest = "Tardo Mucho"
		pedido.cambiarAclaracion(aclaracionTest)
		
		// Assertion
		assertEquals(pedido.aclaracion, aclaracionTest)
	}

	@Test
	def test006SeLeAgregaUnPlatoAlPedido() {
		
		// Exercise
		pedido.agregarPlato(unPlato)
		
		// Assertion
		assertEquals(pedido.platos.size, 1)
		assertFalse(pedido.platos.empty)
	}

	@Test
	def test007SeLeQuitaUnPlatoAlPedido() {
		
		// Exercise
		pedido.agregarPlato(unPlato)
		pedido.quitarPlato (unPlato)

		// Assertion
		assertEquals(pedido.platos.size, 0)
		assertTrue  (pedido.platos.empty)

	}

	@Test
	def test008UnPedidoCalculaCalculaSuPrecio() {
		
		//Setup
		var precioPedido = 0
		
		// Exercise
		pedido.formaDeRetiro = unRetiroEnElLocal
		pedido.agregarPlato(unPlato)
		when(unPlato.calcularPrecio)          .thenReturn(100 /*pesos*/ )
		when(unRetiroEnElLocal.precioDeRetiro).thenReturn(0   /*pesos*/ )
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
	    // SetUp
		val treintaMinitosDespues = LocalDateTime.now.plusMinutes(31)
		pedido.fecha              = treintaMinitosDespues
	
		// Assertion
		assertTrue(pedido.tardoMasDe30Minutos)
	}
	
	@Test
	def test011SiAUnPedidoQueTieneMenosDe30MinutosDeDemoraSeLePReguntaSiTardoMasDe30MinutosDaFalse()
	{
		// Setup
		var horaActual = LocalDateTime.now
		pedido.fecha   = horaActual
		
		// Assertion
		assertFalse(pedido.tardoMasDe30Minutos)
	}
	
	@Test
	def test012UnPedidoConDeliveryCalculaSuPrecio() {
		
		// Setup
		var precioPedido = 0
		
		// Exercise
		pedido.formaDeRetiro = unRetiroConDelivery
		pedido.agregarPlato(unPlato)
		when(unPlato.calcularPrecio)            .thenReturn(100 /*pesos*/ )
		when(unRetiroConDelivery.precioDeRetiro).thenReturn(15 /*pesos*/ )
		precioPedido = pedido.calcularPrecio
		
		// Assertion
		assertEquals(pedido.platos.size, 1)
		assertEquals(115,precioPedido)
	}
}

