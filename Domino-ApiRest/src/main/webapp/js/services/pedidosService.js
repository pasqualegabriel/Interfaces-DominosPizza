'use strict';
dominoApp.service("pedidosService", PedidoRepo);

function PedidoRepo($http){

    var self = this;
    self.pedidoActual   = undefined;
/*    self.pedidosLocales =[];*/
    self.confirmador    = new ConfirmadorDePedidos($http);
    self.pedidos        =  new TraerPedidos($http);

/*    this.addPedidoEnContruccion = function (unPedido) {
        this.pedidosLocales.push(unPedido);
    };*/

    this.newPedido = function (aIdMiembro) {

        self.pedidoActual= new Pedido(aIdMiembro);

    };


/*    this.getPedidoEnContruccionById = function (aId) {
        return _.find(this.pedidosLocales, function (unPedido) {
            return unPedido.idMiembro === aId;
        })
    };*/

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

        self.pedidoActual= new Pedido(pedido.miembro).tranform(pedido.formaDeRetiro,pedido.platosEnConstruccion);
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
