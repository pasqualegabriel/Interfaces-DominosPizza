package agregarPizza

import agregarPizza.EditarPizzaWindow;
import menuPizzas.MenuDeDominoMainWindow;
import pizza.Distribucion;
import pizza.Pizza;

class CrearPizzaWindow extends EditarPizzaWindow{
	
	new(MenuDeDominoMainWindow aMainWindow) {
		super(aMainWindow, new Pizza("", 0, new Distribucion))
	}
	
  override defaultTitle() {
   		 "Crear Nueva Promo"
  }
  
   override accept() {
    	super.accept()
    	this.mainWindow.modelObject.agregarPromocion(super.modelObject)
  }
	
}