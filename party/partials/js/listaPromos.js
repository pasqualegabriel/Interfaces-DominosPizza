'use strict';

/* Controllers */
var promociones = angular.module('listaPromos', []);

promociones.controller
(
	'PromoController', function() 
	{
		/* scope */
		this.listaDePromos = 
			[
			    {
			    	"nombre" : "Jamon",
			    	"descripcion" : "jamoncito",
			    	"precio" : "723"
			    },
			    {
			    	"nombre" : "Muzza",
			    	"descripcion" : "muzzarela",
			    	"precio" : "352"
			    },
			    {
			    	"nombre" : "Morron",
			    	"descripcion" : "morrones",
			    	"precio" : "132"
			    },
			    {
			    	"nombre" : "Anchoa",
			    	"descripcion" : "anchoas",
			    	"precio" : "722"
			    },
			    {
			    	"nombre" : "aa",
			    	"descripcion" : "aa",
			    	"precio" : "722"
			    }
			];

	this.seleccionar = function() 
	{
		/*no hace nada, viteh' */
	};

	}
);
  
  
