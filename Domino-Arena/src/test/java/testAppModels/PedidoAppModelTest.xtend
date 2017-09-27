package testAppModels

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import pedido.PedidoAppModel
import pedido.Pedido
import domino.Miembro
import pedido.Delivery
import pedido.Plato
import pizza.Pizza
import pizza.Distribucion
import pizza.Ingrediente
import pizza.Grande
import pizza.DistribucionEnPizza

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
		
		pedidoDoc 		= new Pedido(new Miembro("Ivan", "nick1", "unpassword3", "pepita@gmail.com", "unaDireccion1"))
		pedidoDoc.formaDeRetiro = new Delivery
		
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
		pedidoSut.calcularPrecio
		assertEquals(pedidoSut.precio, 328.00, 0.0000000000000001)
	}
	
//		@Test
//	def test01coleccionDeEstados() {
//		
//		pedidoSut.coleccionDeEstados
//		assertTrue(pedidoSut.estadosSelector.contains())
//	}

}





