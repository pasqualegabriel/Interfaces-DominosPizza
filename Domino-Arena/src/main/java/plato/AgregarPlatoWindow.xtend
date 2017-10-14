package plato

import org.uqbar.arena.windows.WindowOwner
import pedido.Plato

class AgregarPlatoWindow extends PlatoWindow
{
	
	new(WindowOwner owner, Plato model) 
	{	super(owner, model)	}
	
	override titulo()
	{	"Agregar"	}
}