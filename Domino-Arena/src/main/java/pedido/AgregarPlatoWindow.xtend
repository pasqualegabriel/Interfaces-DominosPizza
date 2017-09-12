package pedido

import plato.EditarPlatoWindow
import plato.PlatoAdapter
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AgregarPlatoWindow extends EditarPlatoWindow  {
	
	new(EditarPedidoWindow  owner) {
		super(owner, new PlatoAdapter(new Plato))
	
	}
	
	override void accept(){
		super.accept
		mainWindow.modelObject.agregarPlatoAdapter(super.modelObject)
	}
}