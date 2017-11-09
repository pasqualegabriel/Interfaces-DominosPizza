dominoApp.controller('SessionCrl', SessionController);


function SessionController($state, sesionService, pedidosService, userService, messageHandler) {

    /* Atributos */

    var self = this;

    self.nick = '';
    self.pass = '';

    this.validUserCredentials = function () {
        return sesionService.validate(self.nick, self.pass).then(self.goToPizza).catch(function(response){ messageHandler.notificarError(response.data.error)});

    };

    this.goToPizza = function(user) {
        userService.setUserLoggin(user);
        self.nuevoPedido();
        $state.go("pizzaSelector");
    };

    this.goRegister = function() {
        $state.go("register");

    };

    this.hayUsuarioLogeado = function(){
        return userService.hayUsuarioLogeado();
    };

    this.nuevoPedido = function(){
        pedidosService.newPedido(userService.getLoggedUserNick());
    };

    this.logInInvitado = function(){
        self.goToPizza(userService.nuevoInvitado());
    };

    this.esUsuarioRegistrado = function()
    {
        return userService.esUsuarioRegistrado();
    }


}

dominoApp.controller('MensajesCrl', MensajesController);


function MensajesController( messageHandler) {

    /* Atributos */

    var self = this;

    self.erroresDuranteLaSesion         = messageHandler.errors;
    self.notificacionesDuranteLaSesion  = messageHandler.msgs;

}
