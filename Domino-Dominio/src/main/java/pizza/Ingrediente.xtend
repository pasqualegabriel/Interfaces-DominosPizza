package pizza

import org.eclipse.xtend.lib.annotations.Accessors

/**
 *  Clase que representa a un ingrediente de una pizza el cual tiene su precio.
 */
@Accessors
class Ingrediente 
{
	
	String nombre
	Integer precio
	
	new(String unNombre, int unPrecio) 
	{
		this.nombre = unNombre
		this.precio = unPrecio
	}

	def nombre()
	{
		this.getNombre
	}
	
	def precio()
	{
		this.getPrecio
	}
	
	def void cambiarPrecio(int nuevoPrecio)
	{
		this.precio = nuevoPrecio
	}
	
	def void cambiarNombre(String unNombre) 
	{
		this.nombre = unNombre
	}
	
}
