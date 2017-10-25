
dominoApp.controller('SessionCrl', function($state, userService) {
    return new SessionModel( $state, userService);
});

function SessionModel($state, userService) {

    /* Atributos */

    this.nick = '';
    this.pass = '';

    /*Protocolo */
    this.chequear = function() {

        var aUser = userService.getUserByNick(this.nick);

        if(aUser === undefined){
            alert("!El usuario no esta registrado¡");
        }else if(aUser.password !== this.pass){
            alert("!El password no es correcto¡");
            }else{
                $state.go("pizzaSelector");
            }
    };

    this.goRegister = function() {
        $state.go("register");

    };

}
