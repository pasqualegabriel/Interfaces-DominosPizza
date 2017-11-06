'use strict';

//cambio
// El nombre del controler era "PizzaModel". Esta mal. Es un controler. Su responsabilidad es la de coneccion
// la responsabilidad de un modelo es la de contener la logica de negocio.
// aca no deberia haber logica de negocio.
// nos van a criticar por un error como ese, mejor evitarlo.

dominoApp.controller('pizzaSelectorCrl', function($state, pizzaService,pedidosService,platoService,userService){

    return new PizzaController($state, pizzaService,pedidosService,platoService,userService);

});


/* Responsabilidad */
// Conectar la vista de SelectorDePizza con el modelo

function PizzaController($state, pizzaService, pedidosService, platoService, userService) {


    /* Atributos */
    var self= this;

    self.listaDePromos = [];

    // Cambio:
    // Conocimiento de mas.

    // antes -->
    // ... (userService.userLoggin.getNick());

    // ahora -->

    self.pedido = pedidosService.getPedidoEnContruccionById(userService.getLoggedUserNick());
    self.precioBase = 0;

    /* Protocolo */

    this.errorHandler = function (error) {
        alert(error.error)
    };

    this.getPromos = function () {
        pizzaService.getPizzas().then(function (listadDePizzaAdaptadas) {
            self.listaDePromos  = listadDePizzaAdaptadas;
        }).catch(function(response){ self.errorHandler(response.data)})
    };

    this.getPrecioBase = function () {
        pizzaService.getPrecioBase().then(function (precioBase) {
            self.precioBase  = precioBase
        }).catch(function(response){ self.errorHandler(response.data)})
    };

    this.getPromos();
    this.getPrecioBase();


    // Cambio:
    // Armando pizzas? en mi controller??? recuerden muchachos: Responsabilidad del controler es cablear
    // Modelo con Vista, nada mas. No deberian crear naranja.

    // Antes -->

    /*

    this.armaTuPizza   = function () {

        var jsonPizzaDTO = {
            "nombre" : "Customizada",
            "precio" : self.precioBase,
            "ingredientes":[]
        };


        var pizza = new PizzaDTO(jsonPizzaDTO);

        self.seleccionar(pizza);

    };
     */

    // Ahora -->

    this.armaTuPizza   = function () {

        var pizza = pizzaService.newCustomPizza(self.precioBase);

        self.seleccionar(pizza);

    };

    this.seleccionar = function(unaPizza)
    {
        var plato = platoService.newPlato(unaPizza);
        self.pedido.setPlatoEnConstruccion(plato);
        $state.go("seleccionDeTamanio",{id: self.pedido.idMiembro});
    };

}
