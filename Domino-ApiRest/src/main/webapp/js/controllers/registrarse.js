'use strict';

dominoApp.controller('RegisterCrl', function ($state, userService) {
    return new RegisterController( $state, userService);

});

/* Responsabilidad */
// Conectar la vista de registrarse con el modelo

function RegisterController($state, userService) {


    /* Atributos */

    var self = this;

    self.nick              = "";

    self.contrasenia       = "";

    self.repitaContrasenia = "";

    self.mail              = "";

    self.direccion         = "";

    self.nombre            = "";


    /* Protocolo */

    self.errorHandler = function (error) {
        alert(error.error)
    };

    this.laContraseniaCoincide = function(){
        return self.contrasenia === self.repitaContrasenia
    };

    this.goToLogin = function() {
        $state.go("logIn");
    };

    this.register = function() {

        if (!this.laContraseniaCoincide()) {

            var error = {error: "Las contraseñas no son iguales"};
            this.errorHandler(error);
        } else {
            var newUser = new Miembro(this.nombre, this.nick, this.contrasenia, this.mail, this.direccion, []);


            var n = {
                "nombre": this.nombre,
                "nick": this.nick,
                "password": this.contrasenia,
                "mail": this.mai,
                "direccion": this.direccio,
                "historialDePedidos": []
            };

            userService.registrarse(n)/*.then(function () {
                $state.go("logIn");
            }).catch(function (response) {
                self.errorHandler(response.data)
            });
        }*/
    }}


}


