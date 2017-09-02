package pizza

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
class Familiar implements Tamanio 
{
	override nombre() 
	{
		"Familiar"
	}
	
	/**
	 * Retorna el factor a aplicarle a un precio.
	 */
	override factorDeTamanio() 
	{
		1.25
	}	
}
