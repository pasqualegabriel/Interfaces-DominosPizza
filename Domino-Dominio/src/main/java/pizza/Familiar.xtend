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
class Familiar extends Tamanio2 
{
	
	new(){
		nombre			= "Familiar"
		factorDeTamanio	= 1.25
		
	}
	
	override getNombre() {
		nombre
	}
	
	override getFactorDeTamanio() {
		factorDeTamanio
	}
	
}
