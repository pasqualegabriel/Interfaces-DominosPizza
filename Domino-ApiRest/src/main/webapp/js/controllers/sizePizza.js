//cambio
// Nombre del controller. De SizeController -> SizeController

dominoApp.controller('sizeSelectorCrl', function ($stateParams, $state, tamanioService,pedidosService) {


    return new SizeController($stateParams, $state, tamanioService,pedidosService);


});


/* Responsabilidad */
// Conectar la vista de IngredientesExtra con el modelo

function SizeController($stateParams, $state, tamanioService, pedidosService){

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion = self.pedido.platoEnContruccion;
    self.tamanios = [];

    this.errorHandler = function (error) {
        alert(error.error)
    };

    //Cambio:
    // Operacion de negocio demaciado inteligente para un controller.
    // Mejor que sea bobo y le pregunte al plato que se calcule solo con un tamaño.

    // antes -->

    //this.aplicarFactorDeTamanioAlPrecioBase = function (aSize) {
    //    return aSize.calcularPrecioPorTamanio(self.platoEnConstruccion.precioBaseDePizza());
    //};

    // ahora -->

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
        $state.go("ingredientesExtras", {id:$stateParams.id });
    };

    this.getSize();
}