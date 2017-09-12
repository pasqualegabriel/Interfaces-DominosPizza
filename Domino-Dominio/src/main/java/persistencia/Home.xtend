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
import java.util.HashMap
import java.time.LocalDateTime
import estados.Entregado
import estados.Cancelado

@Accessors
class Home {
	
	static Home instance
	
	static def getInstance(){
		if (instance == null)
		{ instance = new Home() }
		instance
	}
	
	private new ()
	{
		val distribucion = new Distribucion
		val tamaño		 = new Chica
		val pizza	= new Pizza("Pizza Re piola para villeros",8,distribucion)
		val pizza2	= new Pizza("Pizza llena de Roque",8,distribucion)
		val pizza3 	= new Pizza("La ZAPI FAMILIAR ",8,distribucion)
		agregarPromocion(pizza)
		agregarPromocion(pizza2)
		agregarPromocion(pizza3)
		
		
		val plato		 = new Plato(pizza,tamaño,distribucion)
		val plato2	 	 = new Plato(pizza,tamaño,distribucion)
		
		val pedido1 = new Pedido(new Miembro("Laura", "nick1", "unPassword", "unMail", "unaDireccion"))
		val pedido2 = new Pedido(new Miembro("Maria", "nick1", "unPassword", "unMail", "unaDireccion"))	
		pedido1.formaDeRetiro = new Delivery
		pedido1.estadoActual = new ListoParaEnviar 
		pedido1.fecha = LocalDateTime.of(2017,9,10,19,30)
		pedido2.formaDeRetiro = new Local
		pedido2.estadoActual = new Preparando  
		pedido2.fecha = LocalDateTime.of(2017,9,10,18,30)
		pedido1.agregarPlato(plato)
		pedido1.agregarPlato(plato2)
		pedido2.agregarPlato(plato)
		
		this.pedidosAbiertos.put(nroPedido,pedido1)
		nroPedido ++
		this.pedidosAbiertos.put(nroPedido,pedido2)
		nroPedido ++
		
		/*Pedidos Cerrados*/
		val pizzaMuzzaCerrada			= new Pizza("La Muzza", 15, new Distribucion)
		val platoCerrado1				= new Plato(pizzaMuzzaCerrada,new Familiar,distribucion)
		val pedidoCerrado1 				= new Pedido(new Miembro("La Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado1.agregarPlato(platoCerrado1)
		pedidoCerrado1.formaDeRetiro	= new Local
		pedidoCerrado1.estadoActual		= new Entregado
		pedidoCerrado1.tiempoDeEspera	= 60
		pedidoCerrado1.fecha 			= LocalDateTime.of(2017,9,11,19,30)
		
		val pizzaJamonCerrada			= new Pizza("Pizza Jamon", 25, new Distribucion)
		val platoCerrado2				= new Plato(pizzaJamonCerrada,new Porcion, distribucion)
		val pedidoCerrado2 				= new Pedido(new Miembro("La Lili", "Raquel1", "unPassword", "unMail", "unaDireccion"))
		pedidoCerrado2.agregarPlato(platoCerrado2)
		pedidoCerrado2.formaDeRetiro	= new Local
		pedidoCerrado2.estadoActual		= new Cancelado
		pedidoCerrado2.tiempoDeEspera 	= 0
		pedidoCerrado2.fecha 			= LocalDateTime.of(2017,9,10,19,30)
		
		this.pedidosCerrados.put(nroPedido,pedidoCerrado1)
		nroPedido ++
		this.pedidosCerrados.put(nroPedido,pedidoCerrado2)
		nroPedido ++
	}
	
	// Estructura
	List<Ingrediente> ingredientesDisponibles = newArrayList
	List<Pizza>		  promocionesDisponibles  = newArrayList
	//List<Pedido> 	  pedidosAbiertos		  = newArrayList
	HashMap<Integer, Pedido> pedidosAbiertos  = newHashMap
//	List<Pedido>	  pedidosCerrados		  = newArrayList
	HashMap<Integer, Pedido> pedidosCerrados  = newHashMap	
	int 			  nroPedido 			  = 1
	 
	
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
		pedidosAbiertos.forEach	[clave, valor| if (valor == unPedido)
													moverPedidoAPedidosCerrado(clave,unPedido)
								]
	}

	def void moverPedidoAPedidosCerrado(Integer unNroPedido, Pedido unPedido) 
	{
		pedidosAbiertos.remove(unNroPedido)
		pedidosCerrados.put(unNroPedido,unPedido)
	}
	
	
	// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	// 				 -El pedido no puede ya estar en la lista de pedidos abiertos
	def agregarPedido(Pedido unPedido) { 
		pedidosAbiertos.put(this.nroPedido,unPedido)
	}
	
	def tamanios() 
	{
		#[new Chica, new Porcion, new Grande, new Familiar]
	}


}