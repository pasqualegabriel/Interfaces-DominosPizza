'use strict';

dominoApp.controller('pedidosCtrl', function () {

    return new ConfirmarPedidoModel();
});


function ConfirmarPedidoModel() {

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

    this.tipoDeFormaDeEnvio = "";

    this.quitarDireccion = function () {
        this.direccion= "";
    };

    this.hayPizzas = function () {
       return this.listaDePromos.length > 0
    };

    this.hayFormaDeEnvio = function () {
        return this.tipoDeFormaDeEnvio !== ""
    };

}
