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

import listadoDePedidos.AdapterPedido
import estados.Preparando
import estados.ListoParaRetirar
import estados.Cancelado
import estados.EstadoDePedido
import java.util.ArrayList
import pizza.Pizza
import pizza.Chica
import pizza.Distribucion
import pedido.Plato

class TestAdapterPedido {
	@Mock Miembro unMiembroMock
	@Mock Local unMockLocal
	Pedido unSpyPedido
	AdapterPedido unAdapterTest
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
		unAdapterTest = new AdapterPedido(unSpyPedido, 1)
		when(unMockLocal.avanzarEstado).thenReturn(new ListoParaRetirar)
		when(unMockLocal.precioDeRetiro).thenReturn(12)
		doReturn(new Local).when(unSpyPedido.formaDeRetiro)

	}

	@Test
	def test01UnAdapaterSabeDecirleASuPedidoQuePaseAlSiguienteEstado() {
		unAdapterTest.siguienteEstado
		verify(unSpyPedido).siguiente

	}

	@Test
	def test02UnAdapaterSabeDecirleASuPedidoQuePaseASuAnteriorEstado() {
		unAdapterTest.anteriorEstado
		verify(unSpyPedido).anterior

	}

//	@Test
//	def test03UnAdapterConoceLaColeccionDeEstadosParaElSelector() {
//
//		var unPedido = new Pedido(unMiembroMock)
//		var AdapterPedido unAdapter = new AdapterPedido(unPedido, 1)
//		unPedido.agregarPlato(plato)
//		unPedido.formaDeRetiro = new Local
//		var coleccion = new ArrayList<EstadoDePedido>
//
//		coleccion.add(new Preparando)
//		coleccion.add(new ListoParaRetirar)
//		coleccion.add(new Preparando)
//		coleccion.add(new Cancelado)
//
//		assertEquals(unAdapterTest.estadosSelector.get(0).class, coleccion.get(0).class)
//		assertEquals(unAdapterTest.estadosSelector.get(1).class, coleccion.get(1).class)
//		assertEquals(unAdapterTest.estadosSelector.get(1).class, coleccion.get(1).class)
//		assertEquals(unAdapterTest.estadosSelector.get(2).class, coleccion.get(2).class)
//		
//		for(EstadoDePedido e: unAdapter.estadosSelector){
//			System.out.println(e)
//		}
//		assertTrue(true)
//	}
}
