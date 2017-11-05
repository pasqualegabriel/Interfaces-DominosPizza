

dominoApp.controller('sizeSelectorCrl', function ($stateParams, $state, tamanioService,pedidosService) {


    return new SizeModel($stateParams, $state, tamanioService,pedidosService);


});

function SizeModel($stateParams, $state, tamanioService,pedidosService){

    var self= this;

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion = self.pedido.platoEnContruccion;
    self.tamanios = [];

    this.errorHandler = function (error) {
        alert(error.error)
    };

    this.aplicarFactorDeTamanioAlPrecioBase = function (aSize) {
        return aSize.calcularPrecioPorTamanio(self.platoEnConstruccion.precioBaseDePizza());
    };

    this.getSize=function () {
        tamanioService.getTamanio().then(function (listSize) {
            self.tamanios  = listSize;
        }).catch(this.errorHandler)
    };

    this.armarPizza = function(unTamanio)
    {
        self.platoEnConstruccion.tamanio = unTamanio;
        $state.go("ingredientesExtras", {id:$stateParams.id });
    };

    this.getSize();
}