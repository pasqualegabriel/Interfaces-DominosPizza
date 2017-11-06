'use strict';

dominoApp.controller('pedidosCtrl', ConfirmarPedidoController);

/* Responsabilidad */
// Conectar la vista de ConfirmarPedido con el modelo

function ConfirmarPedidoController($stateParams, pedidosService, formaDeRetiroService) {

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);


    /* Protocolo */

    self.totalAPagar= 0;
    self.tipoDeFormaDeEnvio= new FormaDeRetiro("", "", 0);
    self.nombreDeRetiro= "";

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

    //Cambio
    // Mejor que la propia forma de envio sepa saber si es delivery o no.

    //Antes ->
    // angular.equals(self.tipoDeFormaDeEnvio.tipo,'Delivery')

    //Ahora ->

    this.isNotDelivery=function () {
         return !self.tipoDeFormaDeEnvio.esDelivery();
    };

    this.noHayPlatosNiFormaDeEnvio = function(){
        return !(self.hayPlato() && self.hayFormaDeEnvio())
    };


    // Cambio:
    // Re boludo, pero es los calculos son logica de negocio en el controller.

    // Antes->

    // this.costoTotalAPagar = function(){
    //     return self.tipoDeFormaDeEnvio.precio + self.pedido.costoTotalDelPedido();
    //};

    // Ahora ->

    this.costoTotalAPagar = function(){
        return self.pedido.costoTotalDelPedido(self.tipoDeFormaDeEnvio);
    };

    // Cambio
    // Se crean objetos de negocio en el controller. Aca falta un service.

    /* Antes ->


    this.crearFormaDeRetiro = function(){
        if(EnumFormaDeEnvio.Delivery === self.nombreDeRetiro)
        {
            self.tipoDeFormaDeEnvio= new FormaDeRetiro(EnumFormaDeEnvio.Delivery, "", 15);
        }
        else
        {   self.tipoDeFormaDeEnvio= new FormaDeRetiro(EnumFormaDeEnvio.Local, "", 0); }
        self.costoTotalAPagar()
    };
    */
    // Ahora ->

    this.setFormaDeRetiro = function(){
        self.tipoDeFormaDeEnvio= formaDeRetiroService.newFormaDeRetiro(self.nombreDeRetiro);
        self.costoTotalAPagar()
    };


    this.errorHandler = function (error) {

        alert(error.error)
    };

    this.alert= function (json) {
        alert(json.alerta)
    };


    this.confirmarPedido = function(){

        self.pedido.setFormaDeEnvio(self.tipoDeFormaDeEnvio);
        pedidosService.confirmarPedido(self.pedido).then(self.alert).catch(function(response){ self.errorHandler(response.data)});

    }

}
