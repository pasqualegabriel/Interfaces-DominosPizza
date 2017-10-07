package pizza

import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional
import org.eclipse.xtend.lib.annotations.Accessors

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
@Observable
@Transactional
@Accessors
class Chica extends Tamanio2
{
	new(){
		nombre			= "Chica"
		factorDeTamanio	= 0.50
	}
	
	
	override getNombre() {
		nombre
	}
	
	override getFactorDeTamanio() {
		factorDeTamanio
	}
	
}
