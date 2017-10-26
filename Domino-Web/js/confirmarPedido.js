'use strict';

dominoApp.controller('pedidosCtrl', function () {

    return new ConfirmarPedidoModel();
});


function ConfirmarPedidoModel() {

    this.pepita = "golondrina";

    this.listaDePromos =
        [
            {
                "name" : "Napolitana",
                "ingredientes" : "Queso, Jamon, Muzarella",
                "precio" : 300
            },
            {
                "name" : "Con Morrones",
                "ingredientes" : "Morron, Muzarella",
                "precio" : 100
            },
            {
                "name" : "A La Cancha",
                "ingredientes" : "Morron, Salsa de tomates",
                "precio" : 550
            }
        ];

    this.aclaraciones = "";

    this.precioDeEnvio= 15;

    this.direccion= "";

    this.totalAPagar= 0;

    this.formaDeEnvio= null;

    this.retirarPorLocal = function() {

    };

    this.retirarPorDelivery = function() {

    };
}
