'use strict';
dominoApp.service("pedidosService", function () {
    return new PedidoRepo();
});


function PedidoRepo(){
    this.lastId= 0;

    this.pedidos =   [
    ];

    this.newPedido = function (unMiembro) {
        var unNuevoPedido = new Pedido(this.lastId, unMiembro);
        this.lastId= this.lastId+1;
        return unNuevoPedido;
    };

    this.addPedido = function (unPedido) {
        this.pedidos.push(unPedido);
    };

    this.getPedidoById = function (aId) {
        return _.find(this.pedidos, function (unPedido) {
            return unPedido.id === aId;
        })
    };

}

function Pedido(unId, unMiembro){
    this.id             = unId;
    this.estadoActual   = "";
    this.miembro        = unMiembro;
    this.platos         = [];
    this.fecha          = "";
    this.aclaracion     = "";
    this.formaDeRetiro  = new FormaDeRetiro();
    this.monto          = "";
    this.tiempoDeEspera = "";
}


function FormaDeRetiro(){
    this.tipo             = "";
    this.direccion        = null;
}