package pizza

import org.eclipse.xtend.lib.annotations.Accessorsimport org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Transactional

/**
 *  Clase que representa a un ingrediente de una pizza el cual tiene su precio.
 */
@Accessors
@Observable
@Transactional
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
