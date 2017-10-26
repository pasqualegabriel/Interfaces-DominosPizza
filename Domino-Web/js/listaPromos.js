'use strict';

dominoApp.controller('listaPromosCrl', function($stateParams, pizzaService){

	this.listaDeDistribuciones =  [
	    new PairIngredienteDistribucionPizza("Jamon", new Distribucion()),
        new PairIngredienteDistribucionPizza("Queso", new Distribucion())
    ];

	this.listaDeIngredientes = [
	    new Ingrediente("Jamon" , 123),
        new Ingrediente("Anchoa", 865),
        new Ingrediente("Morron", 354),
        new Ingrediente("Huevo" , 456)
	];

	this.seleccionar = function() 
	{

	};

	this.continuar = function() { 
	}

	}
);

function Ingrediente(aName, aPrecio) {
    this.nombre     = aName;
    this.precio     = aPrecio;

}
  
  
