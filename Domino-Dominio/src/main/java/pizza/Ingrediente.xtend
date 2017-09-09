package pizza

import org.eclipse.xtend.lib.annotations.Accessors

/**
 *  Clase que representa a un ingrediente de una pizza el cual tiene su precio.
 */
@Accessors
@Observable
class Ingrediente 
{
	// Atributos
	String 	nombre
	Integer precio
	
	// Constructor
	new(String unNombre, int unPrecio) 
	{
		this.nombre = unNombre
		this.precio = unPrecio
	}
	
	// Getters & Setters
	def void cambiarPrecio(int nuevoPrecio)
	{
		this.precio = nuevoPrecio
	}
	
	def void cambiarNombre(String unNombre) 
	{
		this.nombre = unNombre
	}
	
}