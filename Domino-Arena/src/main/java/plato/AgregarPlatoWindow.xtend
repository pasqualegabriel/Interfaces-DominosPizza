package plato

import plato.EditarPlatoWindow
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.PedidoWindowEditar
import pedido.Plato

@Accessors
class AgregarPlatoWindow extends EditarPlatoWindow  
{
	new(PedidoWindowEditar  owner) 
	{	super(owner, new PlatoAppModel(new Plato))	}
	
	/**Redefine el metodo para que al aceptar se agregue el plato y calcule el precio*/
	override void accept()
	{
		super.accept
		mainWindow.modelObject.agregarPlato(super.unPlato.plato)
		mainWindow.modelObject.calcularPrecio
	}
}
