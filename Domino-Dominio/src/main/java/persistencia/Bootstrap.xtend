package persistencia

import pizza.Ingrediente
import pizza.Distribucion
import pizza.DistribucionEnPizza
import pizza.Chica
import pizza.Familiar
import pizza.Porcion
import pizza.Pizza
import pedido.Plato
import pedido.Pedido
import domino.Miembro
import pedido.Local
import pedido.Delivery
import estados.ListoParaEnviar
import estados.Preparando
import estados.ListoParaRetirar
import java.time.LocalDateTime
import estados.Entregado
import estados.Cancelado
import pizza.Grande

class Bootstrap {
	def	inicializar(){
				// Creacion de Ingredientes
		val anchoa = new Ingrediente("Anchoa", 3.00)
		val morron = new Ingrediente("Morron", 10.00)
		val jamon = new Ingrediente("Jamon", 7.00)
		HomeIngrediente.instance.agregarIngrediente(anchoa)
		HomeIngrediente.instance.agregarIngrediente(morron)
		HomeIngrediente.instance.agregarIngrediente(jamon)

		// creacion de Distribuciones
		var distribucion1 = new Distribucion
		var distribucion2 = new Distribucion
		var distribucion3 = new Distribucion
		distribucion2.agregarIngrediente(anchoa, DistribucionEnPizza.Toda)
		distribucion3.agregarIngrediente(jamon, DistribucionEnPizza.Izquierda)
		distribucion3.agregarIngrediente(morron, DistribucionEnPizza.Derecha)

		// Creacion de Tamanio		
		var tamanio1 = new Chica
		var tamanio2 = new Familiar
		var tamanio3 = new Porcion

		// creacion de Pizzas
		var pizza1 = new Pizza("Muzzarela", 100.00, distribucion1)
		var pizza2 = new Pizza("Muzza + Anchoas", 120.00, distribucion2)
		var pizza3 = new Pizza("Jamon y morron", 140.00, distribucion3)

		// Agregamos a promos
		HomePizza.instance.agregarPromocion(pizza1)
		HomePizza.instance.agregarPromocion(pizza2)
		HomePizza.instance.agregarPromocion(pizza3)

		// Creacion de platos
		var plato1 = new Plato(pizza1, tamanio1, distribucion1)
		var plato2 = new Plato(pizza2, tamanio2, distribucion2)
		var plato3 = new Plato(pizza3, tamanio3, distribucion3)

		var pedido1 = new Pedido(new Miembro("Ivan", "nick1", 	"unpassword3", "dominikowivan@gmail.com", "unaDireccion1"))
		var pedido2 = new Pedido(new Miembro("Nahuel", "nick2", "unPassword2", "n.autalan@gmail.com", "unaDireccion2"))
		var pedido3 = new Pedido(new Miembro("Gabriel", "nick3","unPassword3", "pasqualeunq@gmail.com", "unaDireccion3"))

		// agregamos forma de retiro al pedido
		pedido1.formaDeRetiro = new Delivery
		pedido2.formaDeRetiro = new Delivery
		pedido3.formaDeRetiro = new Local

		// Agregamos estado de inicio al pedido
		pedido1.estadoActual = new ListoParaEnviar
		pedido2.estadoActual = new Preparando
		pedido3.estadoActual = new ListoParaRetirar

		// Agregamos la fecha a los pedidos
		pedido1.fecha = LocalDateTime.of(2017, 9, 10, 17, 30)
		pedido2.fecha = LocalDateTime.of(2017, 9, 10, 18, 30)
		pedido3.fecha = LocalDateTime.of(2017, 9, 10, 19, 15)

		// Agregamos un plato a cada pedido
		pedido1.agregarPlato(plato1)
		pedido2.agregarPlato(plato2)
		pedido3.agregarPlato(plato3)

		// Agregamos los pedidos a abierto
		HomePedido.instance.agregarPedido(pedido1)
		HomePedido.instance.agregarPedido(pedido2)
		HomePedido.instance.agregarPedido(pedido3)

		/*Pedidos Cerrados*/
		var distribucion4 = new Distribucion
		var distribucion5 = new Distribucion
		val pizzaMuzzaCerrada = new Pizza("Muzza", 15.00, new Distribucion)
		val platoCerrado1 = new Plato(pizzaMuzzaCerrada, new Grande, distribucion4)
		val pedidoCerrado1 = new Pedido(new Miembro("Victor", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado1.agregarPlato(platoCerrado1)
		pedidoCerrado1.formaDeRetiro = new Local
		pedidoCerrado1.estadoActual = new Entregado
		pedidoCerrado1.tiempoDeEspera = 60
		pedidoCerrado1.fecha = LocalDateTime.of(2017, 9, 11, 19, 30)

		val pizzaJamonCerrada = new Pizza("Jamon y Morron", 25.00, new Distribucion)
		val platoCerrado2 = new Plato(pizzaJamonCerrada, new Grande, distribucion5)
		val pedidoCerrado2 = new Pedido(new Miembro("Sr Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado2.agregarPlato(platoCerrado2)
		pedidoCerrado2.formaDeRetiro = new Local
		pedidoCerrado2.estadoActual = new Cancelado
		pedidoCerrado2.tiempoDeEspera = 0
		pedidoCerrado2.fecha = LocalDateTime.of(2017, 9, 10, 19, 30)

		HomePedido.instance.pedidosCerrados.add(pedidoCerrado1)
		HomePedido.instance.pedidosCerrados.add(pedidoCerrado2)
		
	}
}