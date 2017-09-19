package pizza

import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
@Observable
@Transactional
class Chica implements Tamanio 
{
	override nombre() 
	{
		"Chica"
	}
	
	/**
	 * Retorna el factor a aplicarle a un precio.
	 */
	override factorDeTamanio() 
	{
		0.50
	}
	
}
