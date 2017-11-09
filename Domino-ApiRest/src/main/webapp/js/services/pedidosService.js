'use strict';
dominoApp.service("pedidosService", PedidoRepo);

function PedidoRepo($http){

    var self = this;
    self.pedidoActual   = undefined;
    self.confirmador    = new ConfirmadorDePedidos($http);
    self.pedidos        =  new TraerPedidos($http);


    this.newPedido = function (aIdMiembro) {

        self.pedidoActual= new Pedido(aIdMiembro);

    };

    this.getPedidoActual= function () {
        return self.pedidoActual;
    };
    this.confirmarPedido = function(unPedido){
        return this.confirmador.confirmar(unPedido);
    };

    this.getPedido = function (aNick) {
        return self.pedidos.getPedidos(aNick)
    };

    this.repetirPedido = function (pedido) {

        self.pedidoActual= new HidratacionPedido().tranform(pedido);
    }

}

function ConfirmadorDePedidos($http) {

    var transformPedido = function(pedido) { return new PedidoDTO(pedido)};
    return {
        confirmar:  function (unPedido) {
            return $http.post("/pedidos", transformPedido(unPedido));
        }
    }

}

function TraerPedidos($http){
    var getData                 = function(response) { return response.data};
    var tranformPedidoApi       = function (json) { return new PedidoDeApi(json)};
    var historialPedido         = function (json) {return json.pop().historialDePedidos};
    return{
        getPedidos: function(aNick) {
            return $http.get("/usuarios?string=" + aNick).then(getData).then(historialPedido).then(function (list) {
                return list.map(tranformPedidoApi)
            });

        }
    }
}
