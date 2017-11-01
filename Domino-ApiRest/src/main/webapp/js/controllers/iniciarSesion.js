
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


    this.errorHandler = function (error) {

        alert(error.data.error)
    };

    this.validUserCredentials = function () {

        var login = new Login(self.nick, self.pass) ;

        var goToPizza = function(data) {
            pedidosService.newPedido(data.nick);
            $state.go("pizzaSelector", { id: data.nick});
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
