'use strict';

var app = angular.module('agregarPedidosApp', []);

app.controller('pedidosCtrl', function () {


	this.listaDePromos = 
		[
		    {
		    	"name" : "Napolitana",
		    	"ingredientes" : "Queso, Jamon, Muzarella",
		    	"precio" : 300
		    },
		    {
		    	"name" : "Con Morrones",
		    	"ingredientes" : "Morron, Muzarella",
		    	"precio" : 100
		    },
		    {
		    	"name" : "A La Cancha",
		    	"ingredientes" : "Morron, Salsa de tomates",
		    	"precio" : 550
		    }
		];

	this.aclaraciones = "";

	this.precioDeEnvio= 300;

	this.direccion= "";

	this.totalAPagar= 300;

	this.eliminarPiza = function(promo) {
		this.listaDePromos = this.listaDePromos.filter(function())
		delete this.listaDePromos[this.listaDePromos.indexOf(promo)];
	}

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
