'use strict';

dominoApp.controller('RegisterCrl', RegisterController);

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


    this.laContraseniaCoincide = function(){
        return  angular.equals(self.contrasenia,self.repitaContrasenia);

    };

    this.goToLogin = function() {
        $state.go("logIn");
    };

    this.register = function() {

        if (!this.laContraseniaCoincide())
        {
            messageHandler.notificarError("Las contraseñas no son iguales");
        } else {
            var newUser = userService.newUser(self.nombre, self.nick, self.contrasenia, self.mail, self.direccion);
            userService .registrarse(newUser)
                .then(function (response){
                        messageHandler.notificarMensaje(response.data);
                        self.goToLogin();
                    }
                )
                .catch(function (response){messageHandler.notificarError(response.data.error)})
        }
    };


}


