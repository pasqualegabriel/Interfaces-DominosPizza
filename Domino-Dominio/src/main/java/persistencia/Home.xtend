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
		
		val plato		 = new Plato(pizza,tamaño,distribucion)
		
		val pedido1 = new Pedido(new Miembro("Laura", "nick1", "unPassword", "unMail", "unaDireccion"))
		val pedido2 = new Pedido(new Miembro("Maria", "nick1", "unPassword", "unMail", "unaDireccion"))
		
		pedido1.formaDeRetiro = new Delivery
		pedido1.estadoActual = new ListoParaEnviar 
		pedido2.formaDeRetiro = new Local 
		pedido1.agregarPlato(plato)
		pedido2.agregarPlato(plato)
		
		this.pedidosAbiertos.add(pedido1)
		this.pedidosAbiertos.add(pedido2)


	}
	
	// Estructura
	List<Ingrediente> ingredientesDisponibles = newArrayList
	List<Pizza>		  promocionesDisponibles  = newArrayList
	List<Pedido> 	  pedidosAbiertos		  = newArrayList
	List<Pedido>	  pedidosCerrados		  = newArrayList	
	int 			  nroPedido 			  = 0

	
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
	
		// Precondicion: -El pedido no tiene que estar en la lista de pedidos cerrados
	// 				 -El pedido no puede ya estar en la lista de pedidos abiertos
	def agregarPedido(Pedido unPedido) { 
		pedidosAbiertos.add(unPedido)
	}
	
	// Toma un pedido que se encuentra dentro de los pedidos abiertos, lo quita de ahi y lo agrega a los pedidos cerrados
	// Precondicion: El pedido tiene que estar en los pedidos abiertos.
	def void cerrarPedidoEntregado(Pedido unPedido) {
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
	}

	def void agregarPedidosCancelados(Pedido unPedido){
		pedidosAbiertos.remove(unPedido)
		pedidosCerrados.add(unPedido)
		
	}


}