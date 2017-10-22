'use strict';

/* Controllers */

var inicioSesion = angular.module('inicioSesion', ['registrarseApp','editarPizza1', 'ui.router']);

inicioSesion.controller('SesionController', function( $state) {
		/* scope */

		this.name = '';
		this.pass = '';

		//this.inicio = '';

		this.listaDeUsuarios =
		[
			{
		    	"nick" : "g",
		    	"password" : "1"
		    }
		];
/*
		this.verificarUsuario = function(unElemnto)
        {
            var nameR=this.name;
            var passR=this.pass;
            var contiene =false;

                if(nameR===unElemnto.nick && unElemnto.password===passR){
                    contiene=true;

                }
            return contiene;

        };
*/
		this.chequear = function() {

            var nameR=this.name;
            var passR=this.pass;
            var contiene =false;
            angular.forEach(this.listaDeUsuarios, function (element) {
                if(nameR===element.nick && element.password===passR){
                    contiene=true;

                }
            });

		    if(contiene)
            {
                $state.go("editarPizza1");

                //return;
            }
		};

    	this.irARegistrarse = function() {
            $state.go("registrarse");
            //return;

    };


});


