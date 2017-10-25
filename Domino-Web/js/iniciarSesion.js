
dominoApp.controller('SessionCrl', function($state, userService) {
    return new SessionModel( $state, userService);
});

function SessionModel($state, userService) {

    /* Atributos */

    this.nick = '';
    this.pass = '';
    this.selectedUser= undefined;

    /*Protocolo */
    this.chequear = function() {
        this.selectedUser= userService.getUserByNick(this.nick);

        if((this.validUserCredentials()) ){
           // this.registrarInicio();
            $state.go("pizzaSelector");
        }
    };

    this.validUserCredentials = function () {
        return !this.userNotFound() && !this.incorrectPassword()
    };

   // this.registrarInicio = function () {
   //     inicioSesionService.addLogginForUser(this.selectedUser)
   // };

    this.userNotFound = function() {
      return this.selectedUser === undefined
    };

    this.incorrectPassword = function(){
        return this.selectedUser.password !== this.pass
    };

    this.goRegister = function() {
        $state.go("register");

    };

}
