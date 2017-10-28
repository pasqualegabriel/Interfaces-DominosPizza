
dominoApp.controller('SessionCrl', function($state, sesionService,pedidosService) {
    return new SessionModel( $state, sesionService,pedidosService);
});

function SessionModel($state, sesionService,pedidosService) {

    /* Atributos */
    var self = this;

    self.nick = '';
    self.pass = '';
    self.selectedUser= undefined;
    self.user= undefined;


    /*Protocolo */

    this.validUserCredentials = function () {

        var login = {
            "nick" :  self.nick,
            "password" : self.pass
        };

        //new Sesion(self.nick, self.password);

        var cbValidation = function(data) {
            pedidosService.newPedido(data.nick);
            $state.go("pizzaSelector", { id: data.nick});
        };

        var errorHandler = function (error) {

            alert(error.error)
        };

        return sesionService.validation(login,cbValidation,errorHandler)
    };

    this.goRegister = function() {
        $state.go("register");

    };


    <!-- Esto esta para probar la ventana, retirar luego -->
    this.confirmarPedido= function() {
        $state.go("confirmarPedido");
    };

}
