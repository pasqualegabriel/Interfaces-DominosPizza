'use strict';

/* Controllers */
var sesiones = angular.module('inicioSesion', []);

sesiones.controller('SesionController', function() {
		/* scope */

		this.name = '';
		this.pass = '';

		this.inicio = '';

		this.listaDeUsuarios = 
		[
			{
		    	"nick" : "goku",
		    	"password" : "kakaroto"
		    }
		];

		this.chequear = function() { 

			if(this.name=="goku" && this.pass=="kakaroto"){
				this.inicio = 'Se inicio sesion';
			}
		};

	

});
  
  
