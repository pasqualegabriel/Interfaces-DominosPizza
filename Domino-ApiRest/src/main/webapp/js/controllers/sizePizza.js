dominoApp.controller('sizeSelectorCrl', SizeController);


/* Responsabilidad */
// Conectar la vista de IngredientesExtra con el modelo

function SizeController(messageHandler, $state, tamanioService, pedidosService){

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoActual();
    self.platoEnConstruccion = self.pedido.platoEnConstruccion;
    self.tamanios = [];

    this.aplicarFactorDeTamanioAlPrecioBase = function (aSize) {
        return self.platoEnConstruccion.calcularPrecioConTamanio(aSize);
    };

    this.getSize=function () {
        tamanioService.getTamanio().then(function (listSize) {
            self.tamanios  = listSize;
        }).catch(function(response){ messageHandler.notificarError(response.data.error)})
    };

    this.armarPizza = function(unTamanio)
    {
        self.platoEnConstruccion.tamanio = unTamanio;
        $state.go("ingredientesExtras");
    };

    this.getSize();
}