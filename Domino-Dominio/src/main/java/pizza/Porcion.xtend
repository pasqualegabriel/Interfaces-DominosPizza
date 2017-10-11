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
class Porcion extends Tamanio
{
	new(){
		nombre			="Porcion"
		factorDeTamanio	=0.125
	}
	

	
	override getNombre() {
		nombre
	}
	
	override getFactorDeTamanio() {
		factorDeTamanio
	}
	
}
