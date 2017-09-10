package pizza

import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
@Observable
@Transactional
class Porcion implements Tamanio 
{
	override nombre() 
	{
		"Porcion"
	}
	
	/**
	 * Retorna el factor a aplicarle a un precio.
	 */
	override factorDeTamanio() 
	{
		0.125
	}	
}
