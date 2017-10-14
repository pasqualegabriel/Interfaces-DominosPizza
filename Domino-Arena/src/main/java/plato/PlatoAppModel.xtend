package plato

import pedido.Plato
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Dependencies
import persistencia.HomeIngrediente
import pizza.Ingrediente
import org.uqbar.commons.model.utils.ObservableUtils
import pizza.Pizza
import pizza.Tamanio
import persistencia.HomePizza
import persistencia.HomeTamanio
import pizza.PairIngredienteDistribucionPizza

@Accessors
@TransactionalAndObservable
class PlatoAppModel 
{
	Plato unPlato
	
	List<PairIngredienteDistribucionPizza> ingredientesElegidosItems	= newArrayList 
	
	Ingrediente ingredienteExtraSelect
	PairIngredienteDistribucionPizza ingredienteElegidoSelect
	DistribucionEnPizza distribucionSelect
	DistribucionEnPizza distribucionElegidoSelect
	
	Pizza pizzaSelect
	Tamanio sizeSelect
	
	new (Plato platoDePrueba)
	{
		this.unPlato					= platoDePrueba
		this.pizzaSelect				= HomePizza.instance.promocionesDisponibles.findFirst[p | p == platoDePrueba.pizza] 
		this.sizeSelect					= HomeTamanio.instance.tamaniosDisponibles.findFirst[ t | t.esElTamanio(platoDePrueba.tamanio)]
		this.ingredientesElegidosItems	= platoDePrueba.ingredientesExtras.ingredientes
		this.ingredienteExtraSelect		= null
		this.distribucionSelect			= null
		this.ingredienteElegidoSelect	= null
		this.distribucionElegidoSelect	= null
		this.getPrecio
	}
	
	def estaElIngredienteEnLaPizza(Ingrediente unIngrediente)
	{	getIngredientesPizzaItems.exists[n | n.nombre == unIngrediente.nombre]	}
	
	def estaElIngredienteEnLosExtrasElegidos(Ingrediente unIngrediente)
	{	ingredientesElegidosItems.exists[n | n.esElIngrediente(unIngrediente)]	}
	
	def void agregarIngredienteExtraSeleccionado()
	{
		ingredientesElegidosItems.add(new PairIngredienteDistribucionPizza(ingredienteExtraSelect,distribucionSelect))
		this.ingredienteExtraSelect	= null
		this.distribucionSelect		= null
		ObservableUtils.firePropertyChanged(this,"precio")
		ObservableUtils.firePropertyChanged(this,"ingredientesElegidosItems")
		ObservableUtils.firePropertyChanged(this,"ingredientesExtrasItems")
	}
	
	def void quitarIngredienteExtraSeleccionado()
	{
		this.ingredientesElegidosItems.remove(this.ingredienteElegidoSelect)
		this.ingredienteElegidoSelect	= null
		this.distribucionElegidoSelect	= null
		ObservableUtils.firePropertyChanged(this,"ingredientesExtrasItems")
		ObservableUtils.firePropertyChanged(this,"ingredientesElegidosItems")
		ObservableUtils.firePropertyChanged(this,"precio")
	}
	
	def void modificarDistribucionDeIngredienteExtraSeleccionado()
	{
		ingredienteElegidoSelect.distribucion = distribucionElegidoSelect
		distribucionElegidoSelect= null
	}
	
	def void aceptarCambios() 
	{
		unPlato.pizza							= this.pizzaSelect
		unPlato.tamanio							= this.sizeSelect
		unPlato.ingredientesExtras.ingredientes = this.ingredientesElegidosItems
		ObservableUtils.firePropertyChanged(this,"precio")
	}
	
	def costoDeIngredientesExtras()
	{
		if (ingredientesElegidosItems.isEmpty)
			0
		else
			ingredientesElegidosItems.stream.mapToDouble[ parID | parID.ingrediente.precio].sum
	}

	def getIngredientesExtrasItems()
	{
		HomeIngrediente.instance.ingredientesDisponibles.filter[ i | !(estaElIngredienteEnLaPizza(i) || estaElIngredienteEnLosExtrasElegidos(i))].toList
	}

	def getIngredientesPizzaItems()
	{
	 	pizzaSelect.listaDeIngredientes
	}
	
	def getPizzaItems()
	{	HomePizza.instance.promocionesDisponibles	}
	
	def getItemsSize()
	{	HomeTamanio.instance.tamaniosDisponibles	}

	
	def void setPizzaSelect(Pizza unaPizza)
	{
		pizzaSelect = unaPizza
		actualizarIngredientesElegidos
		ObservableUtils.firePropertyChanged(this,"ingredientesPizzaItems")
		ObservableUtils.firePropertyChanged(this,"ingredientesExtrasItems")
		ObservableUtils.firePropertyChanged(this,"ingredientesElegidosItems")
		ObservableUtils.firePropertyChanged(this,"precio")
	}
	
	def actualizarIngredientesElegidos() 
	{
		ingredientesElegidosItems = ingredientesElegidosItems.filter[ i | ingredientesPizzaItems.contains(i) ].toList
	}
	
	def setSizeSelect(Tamanio unTamanio)
	{
		sizeSelect = unTamanio
		ObservableUtils.firePropertyChanged(this,"precio")
	}
	
	@Dependencies(#["pizzaSelect", "sizeSelect", "ingredientesElegidosItems"])
	def getPrecio()
	{	(pizzaSelect.precioBase * sizeSelect.factorDeTamanio + this.costoDeIngredientesExtras).doubleValue	}
	
	def getDistribucionesItems()
	{
		#[DistribucionEnPizza.Toda,DistribucionEnPizza.Izquierda,DistribucionEnPizza.Derecha]
	}
	
	/*Habilitadores de Botones*/
	@Dependencies(#["distribucionSelect", "ingredienteExtraSelect"])
	def getPuedeAgregar()
	{	distribucionSelect!=null && ingredienteExtraSelect!=null	}
	
	@Dependencies("ingredienteElegidoSelect")
	def getHayIngredienteElegido()
	{	ingredienteElegidoSelect!=null	}
	
	@Dependencies("ingredienteExtraSelect")
	def getHayIngredienteExtra()
	{	ingredienteExtraSelect!=null	}
	
	@Dependencies(#["distribucionElegidoSelect", "ingredienteElegidoSelect"])
	def getPuedeModificar()
	{	distribucionElegidoSelect!=null && ingredienteElegidoSelect!=null	}	

	def getTieneIngredientes()
	{	ingredientesPizzaItems.isEmpty()	}
}
