'use strict';
dominoApp.service("pedidosService", function () {
    return new PedidoRepo();
});


function PedidoRepo(){
    this.lastId= 0; //debe pedir al repo cual es el ultimo.

    this.pedidosLocales =   [
    ];

    this.newPedido = function (unMiembro) {
        var unNuevoPedido = new Pedido(this.lastId, unMiembro);
        this.addPedidoEnContruccion(unNuevoPedido);
        this.lastId= this.lastId+1;
        return unNuevoPedido;
    };

    this.addPedidoEnContruccion = function (unPedido) {
        this.pedidosLocales.push(unPedido);
    };

    this.getPedidoEnContruccionById = function (aId) {
        return _.find(this.pedidosLocales, function (unPedido) {
            return unPedido.id === aId;
        })
    };

}
