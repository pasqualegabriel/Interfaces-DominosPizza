package adapterListadoDePedidos
import org.junit.Test
import org.junit.Before
import org.mockito.Mock
import static org.mockito.Mockito.*;
import org.mockito.MockitoAnnotations
import pedido.Pedido
import domino.Miembro

import pedido.Local

import listadoDePedidos.AdapterPedido

class TestAdapterPedido {
	@Mock Miembro 	unMiembroMock
	@Mock Local		unMockLocal		
	Pedido  		unSpyPedido
	AdapterPedido 	unAdapterTest
	
	@Before
	def void setUp() {
		
		MockitoAnnotations.initMocks(this)
		unSpyPedido	= spy(new Pedido(unMiembroMock))
		unSpyPedido.formaDeRetiro = unMockLocal
		unAdapterTest 	= new AdapterPedido(unSpyPedido,1)
		
	}
	
	@Test
	def test01UnAdapaterSabeDecirleASuPedidoQuePaseAlSiguienteEstado(){
		unAdapterTest.siguienteEstado
		verify(unSpyPedido).siguiente
		
	}
	@Test
	def test02UnAdapaterSabeDecirleASuPedidoQuePaseASuAnteriorEstado(){
		unAdapterTest.anteriorEstado
		verify(unSpyPedido).anterior
		
	}
}