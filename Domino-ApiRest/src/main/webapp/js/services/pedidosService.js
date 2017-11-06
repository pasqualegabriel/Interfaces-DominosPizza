'use strict';
dominoApp.service("pedidosService", function () {
    return new PedidoRepo();
});


function PedidoRepo(){

    this.pedidosLocales =[];

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

/* Hay que resolver como utilizarlo, dejar el return suelto te inhabilita los mensajes del service.
    return {
        confirmarPedido:  function (unPedido) {
            return $http.post("/pedidos", unPedido);
        }
    }
*/
}
