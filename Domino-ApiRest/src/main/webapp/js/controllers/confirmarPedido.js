'use strict';

dominoApp.controller('pedidosCtrl', ConfirmarPedidoController);

/* Responsabilidad */
// Conectar la vista de ConfirmarPedido con el modelo

function ConfirmarPedidoController(pedidosService, formaDeRetiroService, $state) {

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoActual();


    /* Protocolo */

    //self.totalAPagar= 0;
    //self.tipoDeFormaDeEnvio= new FormaDeRetiro("", "", 0);
    self.nombreDeRetiro=  "";

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
        return self.pedido.hayFormaDeEnvio()
        //return this.tipoDeFormaDeEnvio.tipo !== ""
    };

    this.isNotDelivery=function () {
        return !self.pedido.formaDeRetiro.esDelivery();
    };

    this.estaListoParaConfirmar = function(){
        return self.hayPlato() && self.hayFormaDeEnvio() && self.direccionValida()
        //return !(self.hayPlato() && self.hayFormaDeEnvio() && self.tipoDeFormaDeEnvio.tieneDireccion())
    };



    this.costoTotalAPagar = function(){
        return self.pedido.costoTotalDelPedido();
        //return self.pedido.costoTotalDelPedido(self.tipoDeFormaDeEnvio);
    };

    this.setFormaDeRetiro = function(){
        //self.tipoDeFormaDeEnvio= formaDeRetiroService.newFormaDeRetiro(self.nombreDeRetiro);
        self.pedido.setFormaDeEnvio( formaDeRetiroService.newFormaDeRetiro(self.nombreDeRetiro));
        self.costoTotalAPagar()
    };

    this.errorHandler = function (error) {

        alert(error.error)
    };

    this.confirmarPedido = function(){
        if(self.estaListoParaConfirmar())
        {
            return pedidosService.confirmarPedido(self.pedido).then(self.goToPizza()).catch(function(response){ self.errorHandler(response.data)});
        }
        else{
            var error =  { error: "No puede continuar. Revise: Que haya platos agregados, que elegio el tipo de envio y si eligio delivery, que haya completado la direccion." };
            this.errorHandler(error)
        }

    };

    this.goToPizza = function() {
        pedidosService.newPedido(self.pedido.idMiembro);
        $state.go("pizzaSelector");
    };

    this.direccionValida = function(){
        return self.pedido.formaDeRetiro.direccionValida()
    };

    this.recargoPorEnvio = function(){
        return self.pedido.formaDeRetiro.precio
    };

    this.formaDeRetiro = function(){
        return self.pedido.formaDeRetiro
    }

}
