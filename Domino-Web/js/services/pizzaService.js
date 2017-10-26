'use strict';
dominoApp.service("pizzaService", function () {

    this.precioBase = 70;

    this.pizzas = [
        new Pizza("Jamon" , "muzzarela con jamon"   , 125),
        new Pizza("Morron", "muzzarela con morron"  , 175),
        new Pizza("Anchoa", "muzzarela con anchoas" , 255)
    ];


    this.newPizza = function (aName, aPost) {
        var aNewPizza= new Pizza(aName,aPost);
        this.addPizza(aNewPizza);
        return aNewPizza;
    };

    this.addPizza=function (aPizza) {
        this.pizzas.push(aPizza);
    };

    this.getDistribucion = function (aPizza) {
        return aPizza.distribucion;
    }

    this.getPizzas = function () {
        return this.pizzas;
    }

    this.getPizzaByName = function (aName) {
        return _.find(this.pizzas, function (aPizza) {
            return aPizza.nombre === aName;
        })
    };


});


function Pizza(aName, aDescription, aPrecio) {

    this.nombre         = aName;
    this.descripcion    = aDescription;
    this.precio         = aPrecio;

    this.distribucion   = [new PairIngredienteDistribucionPizza("Jamon", new Distribucion()),
                           new PairIngredienteDistribucionPizza("Queso", new Distribucion())
    ];
    this.tamanio;

    this.setTamanio = function (aTamanio) {
        this.tamanio = aTamanio;

    };

    this.getDistribuciones = function() {
        return this.distribucion;
    }
/*
    this.descripcion = function () {
        return this.nombre + this.distribucion.forEach(function (t) {
            t.ingrediente()
        });

    }*/
}

function PairIngredienteDistribucionPizza(aIng, aDir) {
    this.ingrediente     = aIng;
    this.distribucion    = aDir;

}

function Distribucion() {
    this.d1    = "Toda";
    this.d2    = "Izquierda";
    this.d3    = "Derecha";

}