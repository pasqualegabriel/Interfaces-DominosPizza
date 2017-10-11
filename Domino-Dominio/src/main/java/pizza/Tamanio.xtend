package pizza



/**
 * Interfaz que representa un tamaño con un factor de precio en base al tamaño.
 */

abstract class Tamanio 
{
	protected String nombre;
	protected Double factorDeTamanio;
	
	def String getNombre()

	def double getFactorDeTamanio()		
}
