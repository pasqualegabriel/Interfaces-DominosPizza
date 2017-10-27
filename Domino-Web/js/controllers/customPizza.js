'use strict';

dominoApp.controller('pizzaSelectorCrl', function($state, pizzaService){

    return new PizzaModel($state, pizzaService);

});

function PizzaModel($state, pizzaService) {

    this.listaDePromos = pizzaService.getPizzas();

    this.precioBase = function () {
        return pizzaService.precioBase;
    };
    
    this.armaTuPizza   = function () {

        $state.go("seleccionDeTamanio",{nombre:pizzaService.newPizza()});

    };

    this.seleccionar = function(unaPizza)
    {
        $state.go("seleccionDeTamanio", {nombre: unaPizza.nombre} );

    };

}


dominoApp.controller('sizeSelectorCrl', function ($stateParams, $state, tamanioService, pizzaService) {


    return new SizeModel($stateParams, $state, tamanioService,pizzaService);


});

function SizeModel($stateParams, $state, tamanioService, pizzaService){

    this.pizzaSeleccionada = pizzaService.getPizzaByName($stateParams.nombre);

    this.listaDePromos = pizzaService.getPizzas();

    this.tamanios = tamanioService.getAll();


    this.precioSegunTamanio= function (unTamanio) {
        return unTamanio.factorDeTamanio * this.pizzaSeleccionada.precioBase;
    };

    this.getTamanio = function () {
        return tamanioCrl.factorDeTamanio();
    };

    this.getDistribucion = function () {
        return tamanioCrl.distribucion();
    };

    this.armarPizza = function(unaPizza, unTamanio)
    {
       //Las pizzas no tienen tamanio, los platos tienen tamanio!! unaPizza.setTamanio(unTamanio);
        $state.go("ingredientesExtras", {nombre: unaPizza.nombre});
    };

}