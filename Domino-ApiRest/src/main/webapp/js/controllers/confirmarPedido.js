'use strict';

dominoApp.controller('pedidosCtrl', ConfirmarPedidoModel);


function ConfirmarPedidoModel($stateParams,pedidosService) {

    var self= this;
    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);

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
    this.isNotDelivery=function () {
         return ! angular.equals(self.tipoDeFormaDeEnvio.tipo,'Delivery')
    };

    this.noHayPlatosNiFormaDeEnvio = function(){
        return !(self.hayPlato() && self.hayFormaDeEnvio())
    };


    this.costoTotalAPagar = function(){
        return self.tipoDeFormaDeEnvio.precio + self.pedido.costoTotalDelPedido();
    };

    this.crearFormaDeRetiro = function(){
        if(EnumFormaDeEnvio.Delivery === self.nombreDeRetiro)
        {
            self.tipoDeFormaDeEnvio= new FormaDeRetiro(EnumFormaDeEnvio.Delivery, "", 15);
        }
        else
        {   self.tipoDeFormaDeEnvio= new FormaDeRetiro(EnumFormaDeEnvio.Local, "", 0); }
        self.costoTotalAPagar()
    };

    this.errorHandler = function (error) {

        alert(error.data.error)
    };

    this.alert= function (json) {
        alert(json.alerta)
    };


    this.confirmarPedido = function(){

        self.pedido.setFormaDeEnvio(self.tipoDeFormaDeEnvio);
        pedidosService.confirmarPedido(self.pedido).then(self.alert).catch(self.errorHandler);

    }

}
