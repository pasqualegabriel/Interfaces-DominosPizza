'use strict';

dominoApp.controller('pedidosCtrl', ConfirmarPedidoController);

/* Responsabilidad */
// Conectar la vista de ConfirmarPedido con el modelo

function ConfirmarPedidoController(messageHandler, pedidosService, formaDeRetiroService, $state) {

    var self= this;
    /* Atributos */

    self.pedido = pedidosService.getPedidoActual();


    /* Protocolo */

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
        return self.pedido.hayFormaDeEnvio()

    };

    this.isNotDelivery=function () {
        return !self.pedido.formaDeRetiro.esDelivery();
    };

    this.estaListoParaConfirmar = function(){
        return self.hayPlato() && self.hayFormaDeEnvio() && self.direccionValida()

    };

    this.costoTotalAPagar = function(){
        return self.pedido.costoTotalDelPedido();

    };

    this.setFormaDeRetiro = function(){
         self.pedido.setFormaDeEnvio( formaDeRetiroService.newFormaDeRetiro(self.nombreDeRetiro));
        self.costoTotalAPagar()
    };


    this.confirmarPedido = function(){
        if(self.estaListoParaConfirmar())
        {
            return pedidosService.confirmarPedido(self.pedido).then(self.goToPizza()).catch(function(response){ messageHandler.notificarError(response.data.error)});
        }
        else{
            var error =  "No puede continuar. Revise: Que haya platos agregados, que elegio el tipo de envio y si eligio delivery, que haya completado la direccion." ;
            messageHandler.notificarError(error)
        }

    };

    this.goToPizza = function() {
        pedidosService.newPedido(self.pedido.idMiembro);
        messageHandler.notificarMensaje("Su pedido comenzara a preparse en breve. Gracias por elegirnos!");
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
    };

    this.cargarNombreDeFormaDeRetiro = function(){
        self.nombreDeRetiro = self.formaDeRetiro().tipo
    };

    this.cargarNombreDeFormaDeRetiro()
}
