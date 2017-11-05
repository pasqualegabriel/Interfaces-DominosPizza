'use strict';

dominoApp.controller('pizzaSelectorCrl', function($state, pizzaService,pedidosService,platoService,userService){

    return new PizzaModel($state, pizzaService,pedidosService,platoService,userService);

});

function PizzaModel($state, pizzaService,pedidosService,platoService,userService) {
    'use strict';
    var self= this;

    self.listaDePromos = [];

    self.pedido = pedidosService.getPedidoEnContruccionById(userService.userLoggin.getNick());

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

        var jsonPizzaDTO = {
            "nombre" : "Customizada",
            "precio" : self.precioBase,
            "ingredientes":[]
        };


        var pizza = new PizzaDTO(jsonPizzaDTO);

        self.seleccionar(pizza);

    };

    this.seleccionar = function(unaPizza)
    {
        var plato = platoService.newPlato(unaPizza);
        self.pedido.setPlatoEnConstruccion(plato);
        $state.go("seleccionDeTamanio",{id: self.pedido.idMiembro});
    };

}
