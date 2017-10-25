'use strict';

dominoApp.service("UsuarioService", function () {

    this.usuarios =   [
        new Usuario("pepita","g","1","pepita@gmail.com","callefalsa123"),
        new Usuario("dionisia","golondrinaVieja","23asdfasdas","dionisia@gmail.com","callefalsa123")
    ];

    this.crearUsuario = function (nombre,nick, password,mail,direccion) {
        var unUsuario = new Usuario(nombre,nick,password,mail,direccion);
        return usuario;
    };

    this.agregarUsuario = function (unUsuario) {
        this.usuarios.push(unUsuario);
    };

    this.getUsuarioByNick = function (unNick) {
        return _.find(this.usuarios, function (unUsuario) {
            return unUsuario.nick === unNick;
        })
    };

});

function Usuario(unNombre, unNick, unPassword, unMail, unaDireccion) {

    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;
    this.historialDePedidos = [];

}