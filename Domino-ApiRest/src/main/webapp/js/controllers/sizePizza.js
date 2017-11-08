dominoApp.controller('sizeSelectorCrl', function ( $state, tamanioService,pedidosService) {


    return new SizeController( $state, tamanioService,pedidosService);


});


/* Responsabilidad */
// Conectar la vista de IngredientesExtra con el modelo

function SizeController($state, tamanioService, pedidosService){

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoActual();
    self.platoEnConstruccion = self.pedido.platoEnConstruccion;
    self.tamanios = [];

    this.errorHandler = function (error) {
        alert(error.error)
    };

    this.aplicarFactorDeTamanioAlPrecioBase = function (aSize) {
        return self.platoEnConstruccion.calcularPrecioConTamanio(aSize);
    };

    this.getSize=function () {
        tamanioService.getTamanio().then(function (listSize) {
            self.tamanios  = listSize;
        }).catch(function(response){ self.errorHandler(response.data)})
    };

    this.armarPizza = function(unTamanio)
    {
        self.platoEnConstruccion.tamanio = unTamanio;
        $state.go("ingredientesExtras");
    };

    this.getSize();
}