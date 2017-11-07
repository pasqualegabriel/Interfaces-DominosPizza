'use strict';
dominoApp.controller('UsuarioCtrl', function (userService) {
	var self = this;
	self.user= userService.userLoggin;

	this.datosDePedido = self.user.historialDePedidos;


    self.nick = self.user.nick;

    self.nombre = self.user.nombre;

    self.mail = self.user.mail;

    self.direccion = self.user.direccion;

    this.repetirPedido = function (pedido) {

    }


});
