package prueba

import pizza.Ingrediente
import pizza.DistribucionEnPizza
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable

@Accessors
@TransactionalAndObservable
class PairAdapterIngredientePizza 
{
	Ingrediente			ingrediente
	DistribucionEnPizza distribucion

	new (Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion)
	{
		ingrediente	= unIngrediente
		distribucion= unaDistribucion
	}
	
	def esElIngrediente(Ingrediente unIngrediente)
	{
		ingrediente.nombre == unIngrediente.nombre
	}

}