'use strict';
dominoApp.service("pedidosService", PedidoRepo);

function PedidoRepo($http){

    this.pedidosLocales =[];
    this.confirmador = new ConfirmadorDePedidos($http);

    this.addPedidoEnContruccion = function (unPedido) {
        this.pedidosLocales.push(unPedido);
    };

    this.newPedido = function (aIdMiembro) {
        var unNuevoPedido = new Pedido(aIdMiembro);
        this.addPedidoEnContruccion(unNuevoPedido);
    };


    this.getPedidoEnContruccionById = function (aId) {
        return _.find(this.pedidosLocales, function (unPedido) {
            return unPedido.idMiembro === aId;
        })
    };

    this.confirmarPedido = function(unPedido){
        return this.confirmador.confirmar(unPedido);
    };

}

function ConfirmadorDePedidos($http) {

    var transformPedido = function(pedido) { return new PedidoDTO(pedido)};
    return {
        confirmar:  function (unPedido) {
            return $http.post("/pedidos", transformPedido(unPedido));
        }
    }

}
