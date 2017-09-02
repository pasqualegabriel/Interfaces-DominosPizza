package pizza

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
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
		0.5
	}
	
}
