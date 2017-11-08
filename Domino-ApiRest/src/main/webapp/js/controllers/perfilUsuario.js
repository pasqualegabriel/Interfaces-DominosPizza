'use strict';
dominoApp.controller('UsuarioCtrl', function (userService,pedidosService,$state,messageHandler) {
	var self = this;
	self.user= userService.userLoggin;

	self.datosDePedido = undefined;


    self.nick = self.user.nick;

    self.nombre = self.user.nombre;

    self.mail = self.user.mail;

    self.direccion = self.user.direccion;


    this.getHistorialDePedidos = function () {
        pedidosService.getPedido(self.nick).then(function (list) {
            self.datosDePedido  = list
        }).catch(function(response){messageHandler.notificarError(response.data.error)});
    };
    this.getHistorialDePedidos();

    this.guardarCambios = function() {
        self.user.nombre    = self.nombre;
        self.user.mail      = self.mail;
        self.user.direccion = self.direccion;

        userService.updateUser(self.user)//.catch(function(response){messageHandler.notificarError(response.data.error)});
    };

    this.repetirPedido=function (aPedido) {
        pedidosService.repetirPedido(aPedido);
        $state.go("confirmarPedido");
    }

});
