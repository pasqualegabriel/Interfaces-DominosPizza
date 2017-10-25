'use strict';

dominoApp.controller('RegisterCrl', function ($state, userService) {
    return new RegisterModel( $state, userService);

});

function RegisterModel($state, userService) {

    this.nick = 'goku';

    this.contrasenia = 'persistencia';

    this.repitaContrasenia = 'persistencia';

    this.mail = 'kakaroto@gmail.com';

    this.direccion = 'vegita 123456';

    this.nombre = 'Kakaroto';


    this.register = function() {
        var aUser    = userService.getUserByNick(this.nick);
        var otherUser= userService.getUserByMail(this.mail);

        /*es villero pero wuacho vamos hacerla corta, ¡PERDON!*/

        if(aUser !==undefined){
            alert("El nick seleccionado ya esta siendo usado por otro usuario")
        }else if(otherUser !==undefined){
            alert("El mail seleccionado ya esta siendo usado por otro usuario")
        } else if(this.contrasenia !== this.repitaContrasenia){
            alert("Las contraseña no coiciden")
        }else{
            userService.newUser(this.nombre,this.nick,this.contrasenia,this.mail,this.direccion);
            $state.go("logIn");
        }
    };
}


