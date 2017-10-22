'use strict';

/* Controllers */
var sesiones = angular.module('inicioSesion', []);

sesiones.controller
(
	this.seCargoUsuario = "falso";
	this.seCargoContraseña = "falso";

	'SesionController', function(String usuario, String contraseña) 
	{
		/* scope */
		this.cargarUsuario = 
			{
		    	"nick" : usuario,
		    	"password" : contraseña
		    };
		this.chequearEIniciarSesion(this.cargarUsuario.nick,this.cargarUsuario.password);

	};




	this.chequearEIniciarSesion = function(String user, String pass) 
	{
		this.seCargoUsuario = user,
		this.seCargoContraseña = pass

	};
);
  
  
