package plato

import plato.EditarPlatoWindow
import plato.PlatoAdapter
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class AgregarPlatoWindow extends EditarPlatoWindow  {
	
	new(pedido.EditarPedidoWindow  owner) {
		super(owner, new PlatoAdapter(new pedido.Plato))
	
	}
	
	override void accept(){
		super.accept
		mainWindow.modelObject.agregarPlatoAdapter(super.unPlatoAdapter)
	}
}
