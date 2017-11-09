package testAppModels

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import pedido.Pedido
import domino.Miembro
import pedido.Delivery
import pedido.Plato
import pizza.Pizza
import pizza.Distribucion
import pizza.Ingrediente
import pizza.Grande
import pizza.DistribucionEnPizza
import estados.Preparando
import pedido.Local
import estados.ListoParaRetirar
import estados.ListoParaEnviar
import estados.EnViaje
import appModels.PedidoAppModel

class PedidoAppModelTest {
	
	Pedido          pedidoDoc
	PedidoAppModel  pedidoSut
	Plato			plato1
	Plato			plato2
	Pizza           pizza1
	Pizza           pizza2
	Distribucion    distribucion1
	Distribucion 	distribucion2
	Ingrediente 	anchoa
	Ingrediente		morron

	@Before
	def void SetUp() {
		
		pedidoDoc 		= new Pedido(new Miembro("Ivan", "nick1", "unpassword3", "pepita@gmail.com", "unaDireccion1"), 0)
		pedidoDoc.formaDeRetiro = new Delivery ("No se Usa")
		
		anchoa 			= new Ingrediente("Anchoa", 3.00)
		distribucion1 	= new Distribucion
		distribucion1.agregarIngrediente(anchoa, DistribucionEnPizza.Toda)
		pizza1 			= new Pizza("Muzzarela", 100.00, new Distribucion)
		plato1 			= new Plato(pizza1, new Grande, distribucion1)
		
		
		morron 			= new Ingrediente("Morron", 10.00)
		distribucion2 	= new Distribucion
		distribucion2.agregarIngrediente(morron, DistribucionEnPizza.Toda)
		pizza2 			= new Pizza("Jamon", 200.00, new Distribucion)
		plato2 			= new Plato(pizza2, new Grande, distribucion2)
		
		
		pedidoDoc.agregarPlato(plato1)
		pedidoDoc.agregarPlato(plato2)
		pedidoSut 		= new PedidoAppModel(pedidoDoc)
		
	}

	@Test
	def test00SeCalculaElPrecioDeUnPedidoAppModel() {
		// $15 delivery
		// $100 del precio base de la piza del primer plato
		// $200 del precio base de la piza del segundo plato
		// $3 del ingradiente de la primera pizza
		// $10 del ingrediente de la segunda pizza
		// Total $328
		assertEquals(pedidoSut.precio, 328.00, 0.0000000000000001)
	}

	@Test
	def test01SeCalculaElPrecioDeUnPedidoAppModelTrasAgregarleUnNuevoPlato() 
	{
		//Setup
		// Total $328 Antes de Agregar un nuevo plato		
		var plato3 			= new Plato(pizza2, new Grande, new Distribucion)
		
		//Excercise
		pedidoSut.agregarPlato(plato3)
		
		//Test
		assertEquals(pedidoSut.precio, 528.00, 0.0000000000000001)
	}
	
	@Test
	def test02SeCalculaElPrecioDeUnPedidoAppModelTrasEliminarleUnPlato() 
	{
		//Setup
		// Total $328 Antes de Agregar un nuevo plato
		pedidoSut.platoSeleccionado = plato2		
		
		//Exercise
		pedidoSut.eliminarPlato()
		
		//Test
		assertEquals(pedidoSut.precio, 118.00, 0.0000000000000001)
	}
	
	@Test
	def test02SiElPedidoTieneEstadoPreparandoYSuFormaDeRetirarEsLocalSuColeccionDeEstadosEsPreparandoYListoParaRetirar() 
	{
		//Setup
		pedidoDoc.estadoActual	= new Preparando
		pedidoDoc.formaDeRetiro = new Local		
		
		//Exercise
		pedidoSut.coleccionDeEstados
		
		//Test
		assertEquals(2,pedidoSut.estadosSelector.size)
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Preparando")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Listo Para Retirar")])
	}
	
	@Test
	def test03SiElPedidoTieneEstadoPreparandoYSuFormaDeRetirarEsDeliverySuColeccionDeEstadosEsPreparandoYListoParaEnviar() 
	{
		//Setup
		pedidoDoc.estadoActual	= new Preparando
		
		//Exercise
		pedidoSut.coleccionDeEstados
		
		//Test
		assertEquals(2,pedidoSut.estadosSelector.size)
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Preparando")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Listo para enviar")])
	}
	
	@Test
	def test04SiElPedidoEstaListoParaRetirarSuColeccionDeEstadosEsPreparandoListoParaRetirarYEntregado() 
	{
		//Setup
		pedidoDoc.estadoActual	= new ListoParaRetirar
		
		//Exercise
		pedidoSut.coleccionDeEstados
		
		//Test
		assertEquals(3,pedidoSut.estadosSelector.size)
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Preparando")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Listo para Retirar")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Entregado")])
	}
	
	@Test
	def test05SiElPedidoEstaListoParaEnviarSuColeccionDeEstadosEsPreparandoListoParaEnviarYEnViaje() 
	{
		//Setup
		pedidoDoc.estadoActual	= new ListoParaEnviar
		
		//Exercise
		pedidoSut.coleccionDeEstados
		
		//Test
		assertEquals(3,pedidoSut.estadosSelector.size)
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Preparando")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Listo para Enviar")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("En Viaje")])
	}

	@Test
	def test06SiElPedidoEstaEnViajeSuColeccionDeEstadosEsListoParaEnviarEnViajeyEntregado() 
	{
		//Setup
		pedidoDoc.estadoActual	= new EnViaje
		
		//Exercise
		pedidoSut.coleccionDeEstados
		
		//Test
		assertEquals(3,pedidoSut.estadosSelector.size)
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Listo para Enviar")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("En Viaje")])
		assertTrue(pedidoSut.estadosSelector.exists[ e | e.nombre.equalsIgnoreCase("Entregado")])
	}
}





