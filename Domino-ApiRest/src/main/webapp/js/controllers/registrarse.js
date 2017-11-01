'use strict';

dominoApp.controller('RegisterCrl', function ($state, userService) {
    return new RegisterModel( $state, userService);

});

function RegisterModel($state, userService) {

    this.nick              = "";

    this.contrasenia       = "";

    this.repitaContrasenia = "";

    this.mail              = "";

    this.direccion         = "";

    this.nombre            = "";


    this.laContraseniaCoincide = function(){
        return this.contrasenia === this.repitaContrasenia
    };

    this.goToLogin = function() {
        $state.go("logIn");
    };

    this.errorHandler = function (error) {
        alert(error.data.error)
    };


    this.register = function() {

        if (! this.laContraseniaCoincide()){
            alert("Las contraseñas no son iguales")
        }else{
            var newUser = new Miembro(this.nombre, this.nick, this.contrasenia, this.mail, this.direccion);

            userService.validate(newUser).then(this.goToLogin).catch(this.errorHandler);
        }



    };



}


