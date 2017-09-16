package agregarPizza

import org.uqbar.commons.model.annotations.Transactional
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import pizza.Pizza
import pizza.Distribucion
import java.util.ArrayList

@Observable
@Accessors
@Transactional
class PromoAppModel {
	
	Pizza pizza 
	List<IngredienteAdapterAbstract> ingredientes
	
	new (Pizza unaPizza){
		pizza=unaPizza
		ingredientes = new ArrayList<IngredienteAdapterAbstract>
	}
	
	def getNombre(){
		pizza.nombre
	}
	
	def void setNombre(String unString){
		pizza.nombre= unString
	}
	
	def getPrecioBase(){
		pizza.precioBase
	}
	
	def void setPrecioBase(Integer unint){
		pizza.precioBase = unint
	}
	
	def agregarIngredientes() {
		pizza.distribucion= new Distribucion
		// hacer esto con lambda
		for (IngredienteAdapterAbstract ingrediente: ingredientes){
			ingrediente.agregarse
		}
	
	}
	
}