'use strict';

dominoApp.controller('pizzaSelectorCrl', function($state, pizzaService,$stateParams,pedidosService,platoService){

    return new PizzaModel($state, pizzaService,$stateParams,pedidosService,platoService);

});

function PizzaModel($state, pizzaService,$stateParams,pedidosService,platoService) {
    'use strict';
    var self= this;

    self.listaDePromos = [];

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);

    self.precioBase = 0;

    this.errorHandler = function (error) {
        alert(error.data.error)
    };

    this.getPromos = function () {

        pizzaService.getPizzas().then(function (listadDePizzaAdaptadas) {
            self.listaDePromos  = listadDePizzaAdaptadas;
        }).catch(this.errorHandler)
    };

    this.getPrecioBase = function () {
        pizzaService.getPrecioBase().then(function (precioBase) {
              self.precioBase  = precioBase
        }).catch(this.errorHandler)
    };

    this.getPromos();
    this.getPrecioBase();



    this.armaTuPizza   = function () {

        /* pensar si es responsabilidad del controller o del service*/

        var pizza = new Pizza("Customizada",self.precioBase);

        var plato = platoService.newPlato(pizza);
        self.pedido.addPlatoEnConstruccion(plato);
        self.pedido.setIdPlatoActual(plato.id);
        $state.go("seleccionDeTamanio",{id: $stateParams.id});


    };

    this.seleccionar = function(unaPizza)
    {
        /* pensar si es responsabilidad del controller o del service*/

        var plato = platoService.newPlato(unaPizza);
        self.pedido.addPlatoEnConstruccion(plato);
        self.pedido.setIdPlatoActual(plato.id);
        $state.go("seleccionDeTamanio",{id: $stateParams.id});

    };

}
