package plato

import plato.EditarPlatoWindow
import org.eclipse.xtend.lib.annotations.Accessors
import pedido.PedidoWindowEditar
import pedido.Plato

@Accessors
class AgregarPlatoWindow extends EditarPlatoWindow  {
	
	new(PedidoWindowEditar  owner) {
		
		super(owner, new Plato)
	
	}
	
	override void accept(){
		super.accept
		mainWindow.modelObject.agregarPlatoAdapter(super.unPlato)
		mainWindow.modelObject.setPrecio
	}
}
