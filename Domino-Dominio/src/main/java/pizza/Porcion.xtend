package pizza

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
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
