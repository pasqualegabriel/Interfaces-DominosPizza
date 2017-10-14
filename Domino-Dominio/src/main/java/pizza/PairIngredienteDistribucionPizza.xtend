package pizza

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import pizza.Ingrediente
import pizza.DistribucionEnPizza

@Accessors
@TransactionalAndObservable
class PairIngredienteDistribucionPizza 
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
	
	def cambiarDistribucion(pizza.DistribucionEnPizza pizza) 
	{	distribucion = pizza	}

}
