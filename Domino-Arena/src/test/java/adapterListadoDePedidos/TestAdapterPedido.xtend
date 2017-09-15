package adapterListadoDePedidos

import org.junit.Test
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.*;
import org.mockito.MockitoAnnotations
import pedido.Pedido
import domino.Miembro
import static org.junit.Assert.*
import pedido.Local
import estados.ListoParaRetirar
import pizza.Pizza
import pizza.Chica
import pizza.Distribucion
import pedido.Plato
import estados.Preparando
import estados.Entregado
import estados.Cancelado
import estados.EnViaje
import estados.ListoParaEnviar
import listadoDePedidos.PedidoAppModel

class TestAdapterPedido {
	@Mock Miembro unMiembroMock
	@Mock Local unMockLocal
	Pedido unSpyPedido
	PedidoAppModel unAdapterTest
	Plato plato

	@Before
	def void setUp() {

		val distribucion = new Distribucion
		val tamaño = new Chica
		val pizza = new Pizza("Pizza Re piola para villeros", 8, distribucion)
		plato = new Plato(pizza, tamaño, distribucion)
		MockitoAnnotations.initMocks(this)
		unSpyPedido = (new Pedido(unMiembroMock))
		unSpyPedido.agregarPlato = plato
		unSpyPedido.formaDeRetiro = unMockLocal
		unAdapterTest = new PedidoAppModel(1, unSpyPedido,true)
		when(unMockLocal.avanzarEstado).thenReturn(new ListoParaRetirar)
		when(unMockLocal.precioDeRetiro).thenReturn(12)
		

	}


	@Test
	def test01UnAdapaterSabeDecirleASuPedidoQuePaseAlSiguienteEstado() {
		unAdapterTest.pasarASiguienteEstado
		assertEquals(unAdapterTest.estadoActual,unSpyPedido.formaDeRetiro.avanzarEstado.nombre)
	}
	

	@Test
	def test02UnAdapaterSabeDecirleASuPedidoQuePaseASuAnteriorEstado() {
		unAdapterTest.pasarAAnteriorEstado
		assertEquals(unAdapterTest.estadoActual,unSpyPedido.estadoActual.previo.nombre)

	}
	
	
	@Test
	def test03UnAdapterConoceLaColeccionDeEstadosParaElSelector() {
		
		var coleccionRespuesta = newArrayList
		coleccionRespuesta.add(new Entregado)
		coleccionRespuesta.add(new Preparando)
		coleccionRespuesta.add(new Cancelado)
		coleccionRespuesta.add(new EnViaje)
		coleccionRespuesta.add(new ListoParaEnviar)
		coleccionRespuesta.add(new ListoParaRetirar)
		assertEquals(coleccionRespuesta.size,unAdapterTest.estadosSelector.size)
		assertEquals(coleccionRespuesta.get(0).class,unAdapterTest.estadosSelector.get(0).class)
		assertEquals(coleccionRespuesta.get(1).class,unAdapterTest.estadosSelector.get(1).class)
		assertEquals(coleccionRespuesta.get(2).class,unAdapterTest.estadosSelector.get(2).class)
		assertEquals(coleccionRespuesta.get(3).class,unAdapterTest.estadosSelector.get(3).class)
		assertEquals(coleccionRespuesta.get(4).class,unAdapterTest.estadosSelector.get(4).class)
		assertEquals(coleccionRespuesta.get(5).class,unAdapterTest.estadosSelector.get(5).class)

	}
}
