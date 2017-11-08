'use strict';
dominoApp.controller('UsuarioCtrl', function (userService,pedidosService,$state) {
	var self = this;
	self.user= userService.userLoggin;

	self.datosDePedido = undefined;


    self.nick = self.user.nick;

    self.nombre = self.user.nombre;

    self.mail = self.user.mail;

    self.direccion = self.user.direccion;

    self.errorHandler = function (error) {

        alert(error.error)
    };

    this.getHistorialDePedidos = function () {
        pedidosService.getPedido(self.nick).then(function (list) {
            self.datosDePedido  = list;
            alert(list)
        }).catch(self.errorHandler);
    };
    this.getHistorialDePedidos();

    this.repetirPedido=function (aPedido) {
        pedidosService.repetirPedido(aPedido);
        $state.go("confirmarPedido");
    }

});
