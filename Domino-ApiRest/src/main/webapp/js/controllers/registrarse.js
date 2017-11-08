'use strict';

dominoApp.controller('RegisterCrl', function ($state, userService,messageHandler) {
    return new RegisterController( $state, userService,messageHandler);

});

/* Responsabilidad */
// Conectar la vista de registrarse con el modelo

function RegisterController($state, userService,messageHandler) {


    /* Atributos */

    var self = this;

    self.nick              = "";

    self.contrasenia       = "";

    self.repitaContrasenia = "";

    self.mail              = "";

    self.direccion         = "";

    self.nombre            = "";


    /* Protocolo */

/*    self.errorHandler = function (error) {
        alert(error.error)
    };
*/
    this.laContraseniaCoincide = function(){
        return self.contrasenia === self.repitaContrasenia
    };

    this.goToLogin = function() {
        $state.go("logIn");
    };

    this.register = function() {

        if (!this.laContraseniaCoincide())
        {
            messageHandler.notificarError("Las contraseñas no son iguales");
        } else {
            var newUser = new Miembro(this.nombre, this.nick, this.contrasenia, this.mail, this.direccion, []);

            userService .registrarse(newUser)
                        .then(function (response){
                                                    alert(response.data);
                                                    self.goToLogin();
                                                 }
                             )
                        .catch(function (response) { messageHandler.notificarError(response.data.error)})
        }
    }


}


