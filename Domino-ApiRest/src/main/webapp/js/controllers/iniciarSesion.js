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
        pedidosService.newPedido(user.nick);
        userService.setUserLoggin(user);
        $state.go("pizzaSelector");
    };

    this.goRegister = function() {
        $state.go("register");

    };

    this.hayUsuarioLogeado = function(){
        return userService.hayUsuarioLogeado();
    }

}

dominoApp.controller('MensajesCrl', MensajesController);


function MensajesController( messageHandler) {

    /* Atributos */

    var self = this;

    self.erroresDuranteLaSesion         = messageHandler.errors;
    self.notificacionesDuranteLaSesion  = messageHandler.msgs;

}
