'use strict';

var app = angular.module('editarUsuarioApp', []);

app.controller('UsuarioCtrl', function () {

	this.datosDePedido = [{
		"pizza": "Muzza",
		"direccion": "dir1",
		"monto": "100",
	}, {
		"pizza": "Huevo",
		"direccion": "dir2",
		"monto": "130",
	}, {
		"pizza": "Morron",
		"direccion": "dir3",
		"monto": "110",
	}, {
		"pizza": "Jamon",
		"direccion": "dir4",
		"monto": "140",
	}];

	this.userName = 'UsuarioGoku';

	this.nombre = 'goku';

	this.mail = 'kakaroto@gmail.com';

	this.direccion = 'vegita 123456';

	this.firstName = 'aaa';

	this.lastName = 'fffff';

});
