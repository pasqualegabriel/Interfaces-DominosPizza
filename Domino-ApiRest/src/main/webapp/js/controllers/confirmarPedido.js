'use strict';

dominoApp.controller('pedidosCtrl', ConfirmarPedidoController);

/* Responsabilidad */
// Conectar la vista de ConfirmarPedido con el modelo

function ConfirmarPedidoController($stateParams, pedidosService, formaDeRetiroService, $state) {

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);


    /* Protocolo */

    self.totalAPagar= 0;
    self.tipoDeFormaDeEnvio= new FormaDeRetiro("", "", 0);
    self.nombreDeRetiro=  this.tipoDeFormaDeEnvio.direccion;

    this.cancelarPlato = function(plato){
        self.pedido.eliminarPlato(plato);
    };

    this.getCollecionDePlatos = function () {
        return self.pedido.platosConfirmados
    };

    this.hayPlato = function () {
        return self.getCollecionDePlatos().length > 0
    };

    this.hayFormaDeEnvio = function () {
        return this.tipoDeFormaDeEnvio.tipo !== ""
    };

    this.isNotDelivery=function () {
         return !self.tipoDeFormaDeEnvio.esDelivery();
    };

    this.validar = function(){
        return !(self.hayPlato() && self.hayFormaDeEnvio() && self.tipoDeFormaDeEnvio.tieneDireccion())
    };



    this.costoTotalAPagar = function(){
        return self.pedido.costoTotalDelPedido(self.tipoDeFormaDeEnvio);
    };

    this.setFormaDeRetiro = function(){
        self.tipoDeFormaDeEnvio= formaDeRetiroService.newFormaDeRetiro(self.nombreDeRetiro);
        self.costoTotalAPagar()
    };


    this.errorHandler = function (error) {

        alert(error.error)
    };

    this.confirmarPedido = function(){
        self.pedido.setFormaDeEnvio(self.tipoDeFormaDeEnvio);
        return pedidosService.confirmarPedido(self.pedido).then(self.goToPizza).catch(function(response){ self.errorHandler(response.data)});
    };

    this.goToPizza = function() {
        pedidosService.newPedido($stateParams.id);
        $state.go("pizzaSelector");
    };
}
