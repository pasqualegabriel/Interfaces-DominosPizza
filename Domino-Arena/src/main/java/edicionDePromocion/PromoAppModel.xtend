package edicionDePromocion

import org.uqbar.commons.model.annotations.Transactional
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.util.List
import pizza.Pizza
import pizza.Distribucion
import java.util.ArrayList
import edicionDePromocion.IngredienteAdapterAbstract

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
		
	def getPrecioBase(){
		pizza.precioBase
	}
	
	def void setPrecioBase(Double unNumero){
		pizza.precioBase = unNumero
	}

	def void setNombre(String unString) {
		pizza.nombre = unString
	}
	
	def agregarIngredientes() {
		pizza.distribucion= new Distribucion
		ingredientes.forEach[ i | i.agregarse]
	
	}
	
	def aceptarCambios(){
		if(pizza.nombre.length>0 && pizza.precioBase != null){
			agregarIngredientes
		}
		else throw new edicionDePromocion.NombrePrecioException ("No hay nombre ni precio")
	}
	
}
