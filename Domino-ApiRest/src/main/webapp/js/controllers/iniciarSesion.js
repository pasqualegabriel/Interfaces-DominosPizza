dominoApp.controller('SessionCrl', function($state, sesionService,pedidosService,userService) {
    return new SessionController( $state, sesionService,pedidosService,userService);
});


function SessionController($state, sesionService, pedidosService, userService) {

    /* Atributos */

    var self = this;

    self.nick = '';
    self.pass = '';


    this.errorHandler = function (error) {

        alert(error.error)
    };

    this.validUserCredentials = function () {
        return sesionService.validate(self.nick, self.pass).then(self.goToPizza).catch(function(response){ self.errorHandler(response.data)});

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
