

dominoApp.controller('sizeSelectorCrl', function ($stateParams, $state, tamanioService,pedidosService) {


    return new SizeModel($stateParams, $state, tamanioService,pedidosService);


});

function SizeModel($stateParams, $state, tamanioService,pedidosService){

    var self= this;

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion = self.pedido.searchPlato(self.pedido.idPlatoActual);
    self.tamanios = [];


    this.errorHandler = function (error) {
        alert(error.error)
    };

    this.updateMoney= function (aSize) {
        aSize.aplicarFactorDeTamanio(self.platoEnConstruccion.precioBaseDePizza());
        return aSize;
    };

    this.getSize=function () {
        tamanioService.getTamanio().then(function (listSize) {
            self.tamanios  = listSize.map(self.updateMoney);
        }).catch(this.errorHandler)
    };

    this.getSize();

    this.armarPizza = function(unTamanio)
    {
        self.platoEnConstruccion.tamanio = unTamanio;
        $state.go("ingredientesExtras", {id:$stateParams.id });
    };

}