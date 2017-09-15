package persistencia

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import pizza.Pizza
import pizza.Ingrediente
import pedido.Pedido
import domino.Miembro
import pedido.Delivery
import pedido.Local
import estados.ListoParaEnviar
import pizza.Distribucion
import pedido.Plato
import pizza.Chica
import pizza.Porcion
import pizza.Grande
import pizza.Familiar
import estados.Preparando
import java.time.LocalDateTime
import estados.Entregado
import estados.Cancelado
import estados.ListoParaRetirar
import pizza.DistribucionEnPizza

@Accessors
class Home {
	
	static Home instance
	
	static def getInstance(){
		if (instance == null)
		{ instance = new Home() }
		instance
	}
	
	// Estructura
	List<Ingrediente> ingredientesDisponibles = newArrayList
	List<Pizza>		  promocionesDisponibles  = newArrayList
	List<Pedido> 	  pedidosAbiertos		  = newArrayList
    List<Pedido>	  pedidosCerrados		  = newArrayList
	int 			  nroPedido 			  = 1

	private new ()
	{
		
			
		//Creacion de Ingredientes
		val anchoa = new Ingrediente("Anchoa",3)
		val morron = new Ingrediente("Morron",10)
		val jamon  = new Ingrediente("Jamon" ,7)
		agregarIngrediente(anchoa)
		agregarIngrediente(morron)
		agregarIngrediente(jamon)
		
		//creacion de Distribuciones
		var distribucion1 = new Distribucion
		var distribucion2 = new Distribucion
		var distribucion3 = new Distribucion
		distribucion2.agregarIngrediente(anchoa,DistribucionEnPizza.Toda)
		distribucion3.agregarIngrediente(jamon,DistribucionEnPizza.Izquierda)
		distribucion3.agregarIngrediente(morron,DistribucionEnPizza.Derecha)
		
		//Creacion de Tamanio		
		var tamanio1	= new Chica
		var tamanio2	= new Familiar
		var tamanio3	= new Porcion
		
		//creacion de Pizzas
		var pizza1	= new Pizza("Muzzarela",100,distribucion1)
		var pizza2	= new Pizza("Muzza + Anchoas",120,distribucion2)
		var pizza3 	= new Pizza("Jamon y morron",140,distribucion3)
		
		//Agregamos a promos
		agregarPromocion(pizza1)
		agregarPromocion(pizza2)
		agregarPromocion(pizza3)
		
		//Creacion de platos
		var plato1		 = new Plato(pizza1,tamanio1,distribucion1)
		var plato2	 	 = new Plato(pizza2,tamanio2,distribucion2)
		var plato3		 = new Plato(pizza3,tamanio3,distribucion3)
		
		var pedido1 = new Pedido(new Miembro("Laura", "nick1", "unPassword1", "unMail1", "unaDireccion1"))
		var pedido2 = new Pedido(new Miembro("Maria", "nick2", "unPassword2", "unMail2", "unaDireccion2"))	
		var pedido3 = new Pedido(new Miembro("Juan", "nick3", "unPassword3", "unMail3", "unaDireccion3"))
		
		//agregamos forma de retiro al pedido
		pedido1.formaDeRetiro = new Delivery
		pedido2.formaDeRetiro = new Local
		pedido3.formaDeRetiro = new Local
		
		//Agregamos estado de inicio al pedido
		pedido1.estadoActual = new ListoParaEnviar 
		pedido2.estadoActual = new Preparando 
		pedido3.estadoActual = new ListoParaRetirar
		
		//Agregamos la fecha a los pedidos
			
		pedido1.fecha = LocalDateTime.of(2017,9,10,17,30)
	 	pedido2.fecha = LocalDateTime.of(2017,9,10,18,30)
		pedido3.fecha = LocalDateTime.of(2017,9,10,19,00)
		
		//Agregamos un plato a cada pedido
		pedido1.agregarPlato(plato1)
		pedido2.agregarPlato(plato2)
		pedido3.agregarPlato(plato3)
		
		//Agregamos los pedidos a abierto
		agregarPedido(pedido1)
		agregarPedido(pedido2)
		agregarPedido(pedido3)
		
	
		
		
		
		/*Pedidos Cerrados*/
		var distribucion4 = new Distribucion
		var distribucion5 = new Distribucion
		val pizzaMuzzaCerrada			= new Pizza("Muzza", 15, new Distribucion)
		val platoCerrado1				= new Plato(pizzaMuzzaCerrada,new Familiar,distribucion4)
		val pedidoCerrado1 				= new Pedido(new Miembro("Sr Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado1.agregarPlato(platoCerrado1)
		pedidoCerrado1.formaDeRetiro	= new Local
		pedidoCerrado1.estadoActual		= new Entregado
		pedidoCerrado1.tiempoDeEspera	= 60
		pedidoCerrado1.fecha 			= LocalDateTime.of(2017,9,11,19,30)
		
		val pizzaJamonCerrada			= new Pizza("Jamon y Morron", 25, new Distribucion)
		val platoCerrado2				= new Plato(pizzaJamonCerrada,new Porcion, distribucion5)
		val pedidoCerrado2 				= new Pedido(new Miembro("Sr Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado2.agregarPlato(platoCerrado2)
		pedidoCerrado2.formaDeRetiro	= new Local
		pedidoCerrado2.estadoActual		= new Cancelado
		pedidoCerrado2.tiempoDeEspera 	= 0
		pedidoCerrado2.fecha 			= LocalDateTime.of(2017,9,10,19,30)
		
		this.pedidosCerrados.add(pedidoCerrado1)
		this.pedidosCerrados.add(pedidoCerrado2)
		
		

	}

	// Metodos
	def ingredientesDisponibles()
	{
		this.getIngredientesDisponibles
	}
	
	def promocionesDisponibles()
	{
		this.getPromocionesDisponibles
	}

	/**
	 * Agrega una pizza a la lista de promociones. Si esta la pizza, no la agrega
	 */	
	def agregarPromocion(Pizza unaPizza) 
	{
		if (!this.promocionesDisponibles().contains(unaPizza)) 
			this.promocionesDisponibles().add(unaPizza)
	}
	
	/**
	 * Quita una pizza de la lista de Promociones. Si no esta la Pizza, lanza una excepcion
	 * Precondicion: tiene que estar la pizza a quitar
	 */
	def borrarPromocion(Pizza unaPizza) 
	{
		if (this.promocionesDisponibles().contains(unaPizza))
			this.promocionesDisponibles().remove(unaPizza)
		else
			throw new RuntimeException("No Esta La Pizza Promocion a sacar a sacar")
	}
	
	/**
	 * Agrega un ingrediente a la lista de ingredientes. Si esta el ingrediente, no lo agrega
	 */
	def agregarIngrediente(Ingrediente unIngrediente) 
	{
		if (!this.ingredientesDisponibles().contains(unIngrediente))
			this.ingredientesDisponibles().add(unIngrediente)
	}
	
	/**
	 * Quita un ingrediente de la lista de ingredientes. Si no esta el ingrediente, lanza una excepcion
	 * Precondicion: tiene que estar el ingrediente a quitar
	 */
	def borrarIngrediente(Ingrediente unIngrediente) 
	{
		if (this.ingredientesDisponibles().contains(unIngrediente))
			this.ingredientesDisponibles().remove(unIngrediente)
		else
			throw new RuntimeException("No Esta el ingrediente a sacar")
	}
	
	// Toma un pedido que se encuentra dentro de los pedidos abiertos, lo quita de ahi y lo agrega a los pedidos cerrados
	// Precondicion: El pedido tiene que estar en los pedidos abiertos.
	def void cerrarPedidoEntregadoCancelado(Pedido unPedido) 
	{
		moverPedidoAPedidosCerrado(unPedido)
	}

	def void moverPedidoAPedidosCerrado(Pedido unPedido) 
	{
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}
	
	
	// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	// 				 -El pedido no puede ya estar en la lista de pedidos abiertos
	def agregarPedido(Pedido unPedido) { 
	
		pedidosAbiertos.add(unPedido)

	}
	
	def tamanios() 
	{
		#[new Chica, new Porcion, new Grande, new Familiar]
	}
	



}