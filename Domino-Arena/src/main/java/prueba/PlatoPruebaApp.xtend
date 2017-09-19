package prueba

import org.uqbar.arena.Application
import pizza.Ingrediente
import pizza.Distribucion
import pizza.DistribucionEnPizza
import pizza.Pizza
import pedido.Plato
import pizza.Familiar

class PlatoPruebaApp extends Application
{

	def nuevoPedidoDePrueba()
	{
		val anchoa 			= new Ingrediente("Anchoa",3)
		val distribucion1 	= new Distribucion()
		val distribucion2 	= new Distribucion()
		distribucion2.agregarIngrediente(anchoa,DistribucionEnPizza.Toda)
		val pizza2			= new Pizza("Muzza + Anchoas",120,distribucion2)
		val tamanio2		= new Familiar
		val plato2	 	 	= new Plato(pizza2,tamanio2,distribucion1)
		plato2
	}

	override protected createMainWindow() {

	

		new PruebaTablaIng(this, nuevoPedidoDePrueba) 
	}
	
	def static void main(String[] args) {
		new PlatoPruebaApp().start()
	}
		
}