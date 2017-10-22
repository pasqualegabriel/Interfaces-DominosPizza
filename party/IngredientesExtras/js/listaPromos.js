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
			    	"name" : "Queso",
			    	"nombre" : "Mitad izquierda",
			    	"descripcion" : "Toda la pizza",
			    	"precio" : "Mitad derecha"
			    },
			    {
			    	"name" : "Tomate",
			    	"nombre" : "Mitad izquierda",
			    	"descripcion" : "Toda la pizza",
			    	"precio" : "Mitad derecha"
			    },
			    {
			    	"name" : "Palmitos",
			    	"nombre" : "Mitad izquierda",
			    	"descripcion" : "Toda la pizza",
			    	"precio" : "Mitad derecha"
			    },
			    {
			    	"name" : "Huevo",
			    	"nombre" : "Mitad izquierda",
			    	"descripcion" : "Toda la pizza",
			    	"precio" : "Mitad derecha"
			    }
			];

	this.listaDeIngredientes = [
		{
			 "nombre" : "Jamon",
			 "precio" : "132"
	    },
	    {
			 "nombre" : "Anchoa",
			 "precio" : "132"
	    },
	    {
			 "nombre" : "Morron",
			 "precio" : "132"
	    },
	    {
			 "nombre" : "Huevo",
			 "precio" : "132"
	    }
	]

	this.seleccionar = function() 
	{
		/*no hace nada, viteh' */
	};

	this.continuar = function() { 
	}

	}
);
  
  
