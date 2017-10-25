
dominoApp.controller('SesionCrl', function( $state, UsuarioService) {
    return new SesionModel( $state, UsuarioService);
});

function SesionModel( $state, UsuarioService) {

    /* Atributos */

    this.nick = '';
    this.pass = '';


    this.chequear = function() {

        var unUsuario = UsuarioService.getUsuarioByNick(this.nick);

        if(unUsuario === undefined){
            alert("!El usuario no esta registrado¡");
        }else if(unUsuario.password !== this.pass){
            alert("!El password no es correcto¡");
            }else{
                $state.go("seleccionDePizza");
            }

/*        if(unUsuario !== undefined && unUsuario.password===this.pass)
        {
            $state.go("seleccionDePizza");
        }*/




    };

    this.irARegistrarse = function() {
        $state.go("registrarse");

    };

}
