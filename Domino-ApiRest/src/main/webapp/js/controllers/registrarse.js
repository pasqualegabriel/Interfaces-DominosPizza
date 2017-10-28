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


    this.register = function() {

        if( this.contrasenia !== this.repitaContrasenia){
            alert("Las contraseñas no son iguales")
        }
        var newUser={
            "nombre": this.nombre ,
            "nick": this.nick,
            "password": this.contrasenia,
            "mail": this.mail,
            "direccion": this.direccion,
            "historialDePedidos": []

        };

        var cbValidation = function(response) {
            $state.go("logIn");
        };

        var errorHandler = function (error) {

            alert(error.data.error)
        };


        userService.validate(newUser,cbValidation,errorHandler);

    };



}


