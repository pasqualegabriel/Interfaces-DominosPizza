'use strict';

dominoApp.controller('RegisterCrl', function ($state, userService) {
    return new RegisterController( $state, userService);

});

/* Responsabilidad */
// Conectar la vista de registrarse con el modelo

function RegisterController($state, userService) {


    /* Atributos */

    var self = this;

    this.nick              = "";

    this.contrasenia       = "";

    this.repitaContrasenia = "";

    this.mail              = "";

    this.direccion         = "";

    this.nombre            = "";


    /* Protocolo */

    this.errorHandler = function (error) {
        alert(error.error)
    };

    this.laContraseniaCoincide = function(){
        return this.contrasenia === this.repitaContrasenia
    };

    this.goToLogin = function() {
        $state.go("logIn");
    };

    this.register = function() {

        if (! this.laContraseniaCoincide()){
            //Cambio
            // En vez de levantar un alert en el procedimiento, se lo paso al errorHandler que sabe encargarse de errores.


            //antes -->

            // alert("las contraseñas no son iguales");

            //ahora -->

            var error=  { error : "Las contraseñas no son iguales"};
            this.errorHandler(error);
        }else{
            var newUser = new Miembro(this.nombre, this.nick, this.contrasenia, this.mail, this.direccion,[] );

            // Cambio:
            // No anda por que volaron el .validate de userService. Hay que rehacerlo.

            // OJO ACA! HAY QUE HACERLO

            userService.validate(newUser).then(this.goToLogin).catch(function(response){ self.errorHandler(response.data)});
        }



    };



}


