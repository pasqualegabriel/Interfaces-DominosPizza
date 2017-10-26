
dominoApp.controller('SessionCrl', function($state, userService, sesionService) {
    return new SessionModel( $state, userService, sesionService);
});

function SessionModel($state, userService, sesionService) {

    /* Atributos */

    this.nick = '';
    this.pass = '';
    this.selectedUser= undefined;

    /*Protocolo */
    this.chequear = function() {
        this.selectedUser= userService.getUserByNick(this.nick);

        if((this.validUserCredentials()) ){
                this.registrarInicio();
                $state.go("pizzaSelector");
        }
    };

    this.validUserCredentials = function () {
        return !this.userNotFound() && !this.incorrectPassword()
    };


    this.registrarInicio = function () {
        sesionService.newSesion(this.selectedUser)
    };

    this.userNotFound = function() {
      return this.selectedUser === undefined
    };

    this.incorrectPassword = function(){
        return this.selectedUser.password !== this.pass
    };

    this.goRegister = function() {
        $state.go("register");

    };


    <!-- Esto esta para probar la ventana, retirar luego -->
    this.confirmarPedido= function() {
        $state.go("confirmarPedido");
    };

}
