package prueba

import pedido.Plato
import java.util.List
import pizza.Ingrediente
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import persistencia.Home
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class PlatoPruebaAppModel 
{
	Plato unPlato
	
	List<DistribucionEnPizza> distribucionesItems				= newArrayList
	List<Ingrediente> ingredientesPizzaItems					= newArrayList
	List<Ingrediente> ingredientesExtrasItems					= newArrayList
	List<PairAdapterIngredientePizza> ingredientesElegidosItems	= newArrayList 
	
	Ingrediente ingredienteExtraSelect
	PairAdapterIngredientePizza ingredienteElegidoSelect
	
	DistribucionEnPizza distribucionSelect
	
	DistribucionEnPizza distribucionElegidoSelect
	
	Integer precio
	
	new (Plato platoDePrueba)
	{
		this.unPlato					= platoDePrueba
		this.ingredientesPizzaItems.addAll(platoDePrueba.pizza.listaDeIngredientes)
		platoDePrueba.ingredientesExtras.ingredientes.forEach[ing , dist| ingredientesElegidosItems.add(new PairAdapterIngredientePizza(ing,dist))]
		this.actualizarIngredientesExtrasDisponibles()
		this.distribucionesItems		= #[DistribucionEnPizza.Toda,DistribucionEnPizza.Izquierda,DistribucionEnPizza.Derecha]
		this.ingredienteExtraSelect		= null
		this.distribucionSelect			= null
		this.ingredienteElegidoSelect	= null
		this.distribucionElegidoSelect	= null
		this.actualizarPrecio
	}

	def getTieneIngredientes()
	{
		ingredientesPizzaItems.isEmpty()
	}
	
	def estaElIngredienteEnLaPizza(Ingrediente unIngrediente)
	{
		ingredientesPizzaItems.exists[n | n.nombre == unIngrediente.nombre]
	}
	
	def estaElIngredienteEnLosExtrasElegidos(Ingrediente unIngrediente)
	{
		ingredientesElegidosItems.exists[n | n.esElIngrediente(unIngrediente)]
	}
	
	def void agregarIngredienteExtraSeleccionado()
	{
		ingredientesElegidosItems.add(new PairAdapterIngredientePizza(ingredienteExtraSelect,distribucionSelect))
		this.actualizarIngredientesExtrasDisponibles()
		this.ingredienteExtraSelect	= null
		this.distribucionSelect		= null
		this.actualizarPrecio
	}
	
	@Dependencies("distribucionSelect","ingredienteExtraSelect")
	def getPuedeAgregar()
	{
		distribucionSelect!=null && ingredienteExtraSelect!=null
	}
	
	def void actualizarIngredientesExtrasDisponibles()
	{
		this.ingredientesExtrasItems.clear
		this.ingredientesExtrasItems.addAll(Home.instance.getIngredientesDisponibles.filter[ i | !(estaElIngredienteEnLaPizza(i) || estaElIngredienteEnLosExtrasElegidos(i))])
		this.actualizarPrecio
	}
	
	def void quitarIngredienteExtraSeleccionado()
	{
		this.ingredientesElegidosItems.remove(this.ingredienteElegidoSelect)
		this.ingredienteElegidoSelect	= null
		this.actualizarIngredientesExtrasDisponibles()
		this.actualizarPrecio
	}
	
	@Dependencies("distribucionElegidoSelect","ingredienteElegidoSelect")
	def getPuedeModificar()
	{
		distribucionElegidoSelect!=null && ingredienteElegidoSelect!=null
	}
	
	def void modificarDistribucionDeIngredienteExtraSeleccionado()
	{
		ingredienteElegidoSelect.distribucion = distribucionElegidoSelect
	}
	
	def costoDeIngredientesExtras()
	{
		if (ingredientesElegidosItems.isEmpty)
			0
		else
			ingredientesElegidosItems.stream.mapToInt[ parID | parID.ingrediente.precio].sum
	}
	
	def void actualizarPrecio()
	{
		precio = (unPlato.pizza.precioBase * unPlato.tamanio.factorDeTamanio + this.costoDeIngredientesExtras).intValue
	}
	
}