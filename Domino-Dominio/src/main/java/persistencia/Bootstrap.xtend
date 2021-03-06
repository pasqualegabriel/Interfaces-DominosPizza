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
import estados.EnViaje

class Bootstrap {
	def	inicializar(){
		
		HomePedido.instance.id = 0
		// Creacion de Ingredientes
		val anchoa = new Ingrediente("Anchoa", 3.00)
		val morron = new Ingrediente("Morron", 10.00)
		val jamon = new Ingrediente("Jamon", 7.00)
		val palmito= new Ingrediente("Palmito con salsa Golf",10.00)
		HomeIngrediente.instance.agregarIngrediente(anchoa)
		HomeIngrediente.instance.agregarIngrediente(morron)
		HomeIngrediente.instance.agregarIngrediente(jamon)
		HomeIngrediente.instance.agregarIngrediente(palmito)
		// creacion de Distribuciones
		var distribucion1 = new Distribucion
		var distribucion2 = new Distribucion
		var distribucion3 = new Distribucion
		var distribucionEspecial = new Distribucion
		distribucion2.agregarIngrediente(anchoa, DistribucionEnPizza.Toda)
		distribucion3.agregarIngrediente(jamon, DistribucionEnPizza.Izquierda)
		distribucion3.agregarIngrediente(morron, DistribucionEnPizza.Derecha)
		
		distribucionEspecial.agregarIngrediente(anchoa, DistribucionEnPizza.Toda)
		distribucionEspecial.agregarIngrediente(jamon, DistribucionEnPizza.Izquierda)
		distribucionEspecial.agregarIngrediente(morron, DistribucionEnPizza.Derecha)
		distribucionEspecial.agregarIngrediente(palmito, DistribucionEnPizza.Derecha)
		
		// Creacion de Tamanio		
		var tamanio1 = new Chica
		var tamanio2 = new Familiar
		var tamanio3 = new Porcion

		// creacion de Pizzas
		var pizza1 = new Pizza("Muzzarela", 100.00, distribucion1)
		var pizza2 = new Pizza("Muzza + Anchoas", 120.00, distribucion2)
		var pizza3 = new Pizza("Jamon y morron", 140.00, distribucion3)
		var pizza4 = new Pizza("Especial de la casa",200.00,distribucionEspecial)

		// Agregamos a promos
		HomePizza.instance.agregarPromocion(pizza1)
		HomePizza.instance.agregarPromocion(pizza2)
		HomePizza.instance.agregarPromocion(pizza3)
		HomePizza.instance.agregarPromocion(pizza4)
		
		//Le damos un precio base a pizza
		HomePizza.instance.precioBase = 70.00

		// Creacion de platos
		var plato1 = new Plato(pizza1, tamanio1, new Distribucion)
		var plato2 = new Plato(pizza2, tamanio2, new Distribucion)
		var plato3 = new Plato(pizza3, tamanio3, new Distribucion)
		
		// Creacion de usuarios
		var ivan    = new Miembro("Ivan", "nick1", 	"unpassword3", "dominikowivan@gmail.com", "unaDireccion1")
		var nahuel  = new Miembro("Nahuel", "nick2", "unPassword2", "n.autalan@gmail.com", "unaDireccion2")
		var gabriel = new Miembro("Gabriel", "nick3","unPassword3", "pasqualeunq@gmail.com", "unaDireccion3")
		var g1 = new Miembro("goku", "g","1", "goku@gmail.com", "Av.SiempreViva")
		
		// Creacion de pedidos
		var pedido1 = new Pedido(ivan,HomePedido.instance.newId)
		var pedido2 = new Pedido(nahuel,HomePedido.instance.newId)
		var pedido3 = new Pedido(gabriel,HomePedido.instance.newId)
		
		var pedido12 = new Pedido(ivan,HomePedido.instance.newId)
		var pedido22 = new Pedido(nahuel,HomePedido.instance.newId)
		var pedido32 = new Pedido(gabriel,HomePedido.instance.newId)
		var pedido42 = new Pedido(gabriel,HomePedido.instance.newId)
		
		var pedido13 = new Pedido(ivan,HomePedido.instance.newId)
		var pedido23 = new Pedido(nahuel,HomePedido.instance.newId)
		var pedido33 = new Pedido(gabriel,HomePedido.instance.newId)
		var pedido43 = new Pedido(gabriel,HomePedido.instance.newId)
		
		// Agrega un pedido al usurio
		var pedidoG1 = new Pedido(g1,HomePedido.instance.newId)
		var plato    = new Plato(pizza4,tamanio1,new Distribucion)
		pedidoG1.agregarPlato(plato)
		pedidoG1.estadoActual = new EnViaje
		g1.agregarPedido(pedidoG1)
		
		var pedidoG2 = new Pedido(g1,HomePedido.instance.newId)
		var platog2    = new Plato(pizza1,tamanio1,distribucion3)
		pedidoG2.formaDeRetiro = new Delivery("El Rey De Los Mini Super 01")
		pedidoG2.agregarPlato(plato)
		pedidoG2.agregarPlato(platog2)
		pedidoG2.estadoActual = new ListoParaEnviar
		g1.agregarPedido(pedidoG2)

		// agregamos forma de retiro al pedido
		pedido1.formaDeRetiro = new Delivery ("Cerrado 128")
		pedido2.formaDeRetiro = new Delivery ("Pepota 5")
		pedido3.formaDeRetiro = new Local

		pedido12.formaDeRetiro = new Delivery ("Cerrado 128")
		pedido22.formaDeRetiro = new Delivery ("Pepota 5")
		pedido32.formaDeRetiro = new Local
		pedido42.formaDeRetiro = new Local
		
		pedido13.formaDeRetiro = new Delivery ("Cerrado 128")
		pedido23.formaDeRetiro = new Delivery ("Pepota 5")
		pedido33.formaDeRetiro = new Local
		pedido43.formaDeRetiro = new Local
		
		// Agregamos estado de inicio al pedido
		pedido1.estadoActual = new ListoParaEnviar
		pedido2.estadoActual = new Preparando
		pedido3.estadoActual = new ListoParaRetirar

		pedido12.estadoActual = new EnViaje
		pedido22.estadoActual = new EnViaje
		pedido32.estadoActual = new EnViaje
		pedido42.estadoActual = new EnViaje
		
		pedido13.estadoActual = new ListoParaEnviar
		pedido23.estadoActual = new ListoParaEnviar
		pedido33.estadoActual = new ListoParaEnviar
		pedido43.estadoActual = new ListoParaEnviar
		
		// Agregamos la fecha a los pedidos
		pedido1.fecha = LocalDateTime.of(2017, 9, 10, 17, 30)
		pedido2.fecha = LocalDateTime.of(2017, 9, 10, 18, 30)
		pedido3.fecha = LocalDateTime.of(2017, 9, 10, 19, 15)
	
		pedido12.fecha = LocalDateTime.of(2017, 9, 10, 20, 30)
		pedido22.fecha = LocalDateTime.of(2017, 9, 11, 18, 30)
		pedido32.fecha = LocalDateTime.of(2017, 9, 1, 19, 15)
		pedido42.fecha = LocalDateTime.of(2017, 10, 10, 19, 15)	
		
		pedido13.fecha = LocalDateTime.of(2017, 9, 10, 0, 30)
		pedido23.fecha = LocalDateTime.of(2017, 11, 12, 18, 30)
		pedido33.fecha = LocalDateTime.of(2017, 9, 3, 19, 15)
		pedido43.fecha = LocalDateTime.of(2017, 10, 10, 9, 15)	
		
		// Agregamos un plato a cada pedido
		pedido1.agregarPlato(plato1)
		pedido2.agregarPlato(plato2)
		pedido3.agregarPlato(plato3)
		
		pedido12.agregarPlato(plato1)
		pedido22.agregarPlato(plato2)
		pedido32.agregarPlato(plato3)
		pedido42.agregarPlato(plato3)
		
		pedido13.agregarPlato(plato3)
		pedido23.agregarPlato(plato3)
		pedido33.agregarPlato(plato1)
		pedido43.agregarPlato(plato1)
		

		// Agregamos los pedidos a abierto
		HomePedido.instance.agregarPedido(pedido1)
		HomePedido.instance.agregarPedido(pedido2)
		HomePedido.instance.agregarPedido(pedido3)
		HomePedido.instance.agregarPedido(pedidoG1)
		HomePedido.instance.agregarPedido(pedidoG2)
		
		HomePedido.instance.agregarPedido(pedido12)
		HomePedido.instance.agregarPedido(pedido22)
		HomePedido.instance.agregarPedido(pedido32)
		HomePedido.instance.agregarPedido(pedido42)
		HomePedido.instance.agregarPedido(pedido13)
		HomePedido.instance.agregarPedido(pedido23)
		HomePedido.instance.agregarPedido(pedido33)
		HomePedido.instance.agregarPedido(pedido43)
		
		// Agregamos los usuarios
		HomeMiembro.instance.registrarUsuario(ivan)
		HomeMiembro.instance.registrarUsuario(gabriel)
		HomeMiembro.instance.registrarUsuario(nahuel)
		HomeMiembro.instance.registrarUsuario(g1)
	
		/*Pedidos Cerrados*/
		var distribucion4 = new Distribucion
		var distribucion5 = new Distribucion
		val pizzaMuzzaCerrada = new Pizza("Muzza", 15.00, new Distribucion)
		val platoCerrado1 = new Plato(pizzaMuzzaCerrada, new Grande, distribucion4)
		val pedidoCerrado1 = new Pedido(new Miembro("Victor", "Raquel1", "unPassword", "unMail", "unaDireccion"),HomePedido.instance.newId)
		pedidoCerrado1.formaDeRetiro = new Local
		pedidoCerrado1.estadoActual = new Entregado
		pedidoCerrado1.tiempoDeEspera = 60
		pedidoCerrado1.fecha = LocalDateTime.of(2017, 9, 11, 19, 30)
		pedidoCerrado1.agregarPlato(platoCerrado1)

		val pizzaJamonCerrada = new Pizza("Jamon y Morron", 25.00, new Distribucion)
		val platoCerrado2 = new Plato(pizzaJamonCerrada, new Grande, distribucion5)
		val pedidoCerrado2 = new Pedido(new Miembro("Sr Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"), HomePedido.instance.newId)
		pedidoCerrado2.formaDeRetiro = new Local
		pedidoCerrado2.estadoActual = new Cancelado
		pedidoCerrado2.tiempoDeEspera = 0
		pedidoCerrado2.fecha = LocalDateTime.of(2017, 9, 10, 19, 30)
		pedidoCerrado2.agregarPlato(platoCerrado2)

		HomePedido.instance.pedidosCerrados.add(pedidoCerrado1)
		HomePedido.instance.pedidosCerrados.add(pedidoCerrado2)
		
	}
	
	def dropAll() {
		HomePedido.instance.deleteAll()
		HomeIngrediente.instance.deleteAll()
		HomeLogin.instance.deleteAll()
		HomeMiembro.instance.deleteAll()
		HomePizza.instance.deleteAll()
		HomeTamanio.instance.deleteAll()
	}
	
}