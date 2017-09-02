package pizza

/* 
 * Implementa la representacion de un tamaño de pizza Chico con su respectivo coeficiente de precio
 */
class Grande implements Tamanio 
{
	override nombre() 
	{
		return "Grande"
	}
	
	/**
	 * Retorna el factor a aplicarle a un precio.
	 */
	override factorDeTamanio() 
	{
		1
	}	
}
