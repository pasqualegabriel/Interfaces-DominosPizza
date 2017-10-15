'use strict';

var app = angular.module('registrarseApp', []);

app.controller('UsuarioCtrl', function () {

	this.userName = 'UsuarioGoku';

	this.contrasenia = 'password';

	this.repitaContrasenia = 'password';

	this.mail = 'kakaroto@gmail.com';

	this.direccion = 'vegita 123456';

	this.nombre = 'Goku';

	this.listaDeUsuarios = [];

	this.registrarse = function() { 
		if(this.contrasenia==this.repitaContrasenia){
			this.listaDeUsuarios.push({
		    	"user" : this.userName,
				"mail": this.mail,
				"nombre": this.nombre,
				"direccion": this.direccion,
				"contrasenia": this.contrasenia
	    	});
		}	
	};


});
