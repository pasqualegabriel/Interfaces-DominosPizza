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

    this.selectedUserbyNick = undefined;
    this.selectedUserbyMail = undefined;

    this.register = function() {
        this.selectedUserbyNick    = userService.getUserByNick(this.nick);
        this.selectedUserbyMail    = userService.getUserByMail(this.mail);

        if(this.esValidoParaRegistrarse()){
            userService.newUser(this.nombre,this.nick,this.contrasenia,this.mail,this.direccion);
            $state.go("logIn");
        }
    };

    this.esValidoParaRegistrarse = function() {
        return !this.elNickYaEstaRegistrado() && !this.elMailYaEstaRegistrado() && this.laContraseniaCoincide()
    };

    this.elNickYaEstaRegistrado = function() {
        return this.selectedUserbyNick !== undefined;
    };

    this.elMailYaEstaRegistrado = function() {
        return this.selectedUserbyMail !== undefined;
    };

    this.laContraseniaCoincide = function(){
        return this.contrasenia === this.repitaContrasenia
    }

}


