
dominoApp.controller('SessionCrl', function($state, sesionService,pedidosService,userService) {
    return new SessionModel( $state, sesionService,pedidosService,userService);
});

function SessionModel($state, sesionService,pedidosService,userService) {

    /* Atributos */
    var self = this;

    self.nick = '';
    self.pass = '';
    self.selectedUser= undefined;
    self.user= undefined;


    /*Protocolo */


    this.errorHandler = function (error) {

        alert(error.data.error)
    };

    this.validUserCredentials = function () {

        var login = new Login(self.nick, self.pass) ;

        var goToPizza = function(data) {
            pedidosService.newPedido(data.nick);
            userService.setUserLoggin(data);
            $state.go("pizzaSelector");
        };

        return sesionService.validate(login).then(goToPizza).catch(this.errorHandler);


    };

    this.goRegister = function() {
        $state.go("register");

    };

    <!-- Esto esta para probar la ventana, retirar luego -->
    this.confirmarPedido= function() {
        $state.go("confirmarPedido");
    };

}
