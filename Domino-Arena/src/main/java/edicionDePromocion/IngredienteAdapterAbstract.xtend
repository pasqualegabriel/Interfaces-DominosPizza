package edicionDePromocion

import pizza.Ingrediente
import pizza.DistribucionEnPizza
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Transactional


@Observable
@Accessors
@Transactional
abstract class IngredienteAdapterAbstract {
	
	protected Ingrediente ingrediente

	protected Boolean activado

	protected DistribucionEnPizza distribucionSeleccionada
	
	
	new (Ingrediente unIngrediente){
		ingrediente = unIngrediente
	}
	
	def getDistribuciones() {
		#[DistribucionEnPizza.Izquierda, DistribucionEnPizza.Toda, DistribucionEnPizza.Derecha]
	}
	
	def void agregarse()
	
	def Double getGetPrecio(){
		if(activado && distribucionSeleccionada != null){
			return this.ingrediente.precio
		}
		0.00
	}
	
}
