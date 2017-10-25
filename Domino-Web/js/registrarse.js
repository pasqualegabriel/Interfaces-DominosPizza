'use strict';

dominoApp.controller('RegistrarseCrl', function ( $state) {

    this.userName = 'UsuarioGoku';

    this.contrasenia = 'password';

    this.repitaContrasenia = 'password';

    this.mail = 'kakaroto@gmail.com';

    this.direccion = 'vegita 123456';

    this.nombre = 'Goku';




    this.listaDeUsuarios = [];

    this.registrarse = function() {
        if(this.contrasenia==this.repitaContrasenia){
            $state.go("iniciarSesion");
            return;
        }

    };


});

  
