'use strict';

dominoApp.controller('pizzaSelectorCrl', function($state, pizzaService,$stateParams,pedidosService,platoService){

    return new PizzaModel($state, pizzaService,$stateParams,pedidosService,platoService);

});

function PizzaModel($state, pizzaService,$stateParams,pedidosService,platoService) {
    'use strict';
    var self= this;

    self.listaDePromos = [];

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);

    this.getPromos = function () {

        var errorHandler = function (error) {
            alert(error.error)
        };

        pizzaService.getPizzas().then(function (listadDePizzaAdaptadas) {
            self.listaDePromos  = listadDePizzaAdaptadas;
        }).catch(errorHandler)
    };

    this.getPromos();



    this.precioBase = function () {
        return pizzaService.precioBase;
    };
    
    this.armaTuPizza   = function () {

        $state.go("seleccionDeTamanio",{nombre:pizzaService.newPizza()});

    };

    this.seleccionar = function(unaPizza)
    {
        var plato = platoService.newPlato(unaPizza);
        self.pedido.addPlato(plato);
        self.pedido.setIdPizzaActual(unaPizza.nombre);

        $state.go("seleccionDeTamanio",{id: $stateParams.id});

    };

}


dominoApp.controller('sizeSelectorCrl', function ($stateParams, $state, tamanioService,pizzaService,pedidosService) {


    return new SizeModel($stateParams, $state, tamanioService,pizzaService,pedidosService);


});

function SizeModel($stateParams, $state, tamanioService,pizzaService,pedidosService){

    var self= this;

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);

    self.idPizzaActual     = self.pedido.idPizzaActual;
    self.pizzaSeleccionada = self.pedido.searchPizza(self.idPizzaActual).pizza;


    self.tamanios = [];

    this.getSize=function () {
        var errorHandler = function (error) {
            alert(error.error)
        };

        var updateMoney= function (aSize) {
            aSize.calcularPrecio(self.pizzaSeleccionada.precioBase);
            return aSize;
        };

        tamanioService.getTamanio().then(function (listSize) {
            self.tamanios  = listSize.map(updateMoney);
        }).catch(errorHandler)
    };

    this.getSize();


    this.armarPizza = function(unaPizza, unTamanio)
    {
       //Las pizzas no tienen tamanio, los platos tienen tamanio!! unaPizza.setTamanio(unTamanio);
        $state.go("ingredientesExtras", {nombre: unaPizza.nombre});
    };

}