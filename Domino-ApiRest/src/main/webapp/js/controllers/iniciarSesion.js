dominoApp.controller('SessionCrl', SessionController);


function SessionController($state, sesionService, pedidosService, userService, errorHandler) {

    /* Atributos */

    var self = this;

    self.nick = '';
    self.pass = '';
    self.erroresDuranteLaSesion         = errorHandler.errors;
    self.notificacionesDuranteLaSesion  = errorHandler.msgs;

    this.validUserCredentials = function () {
        return sesionService.validate(self.nick, self.pass).then(self.goToPizza).catch(function(response){ errorHandler.notificarError(response.data.error)});

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
