'use strict';

dominoApp.controller('pizzaSelectorCrl',PizzaController);


/* Responsabilidad */
// Conectar la vista de SelectorDePizza con el modelo

function PizzaController(messageHandler, $state, pizzaService, pedidosService, platoService) {

    /* Atributos */
    var self= this;

    self.listaDePromos = [];

    self.precioBase = 0;

    /* Protocolo */

    this.getPromos = function () {
        pizzaService.getPizzas().then(function (listadDePizzaAdaptadas) {
            self.listaDePromos  = listadDePizzaAdaptadas;
        }).catch(function(response){ messageHandler.notificarError(response.data.error)})
    };

    this.getPrecioBase = function () {
        pizzaService.getPrecioBase().then(function (precioBase) {
            self.precioBase  = precioBase
        }).catch(function(response){ messageHandler.notificarError(response.data.error)})
    };

    this.getPromos();
    this.getPrecioBase();


    this.armaTuPizza   = function () {

        var pizza = pizzaService.newCustomPizza(self.precioBase);

        self.seleccionar(pizza);

    };

    this.seleccionar = function(unaPizza)
    {
        var plato = platoService.newPlato(unaPizza);
        pedidosService.getPedidoActual().setPlatoEnConstruccion(plato);
        $state.go("seleccionDeTamanio");
    };

}
