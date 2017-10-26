'use strict';
dominoApp.service("ingredienteService", function () {
    return new IngredienteRepo();
});


function IngredienteRepo(){

    this.ingredientes =   [
        new Ingrediente("Anchoa",3),
        new Ingrediente("Jamon",2)
    ];

    this.getAllIngredientes = function () {
        return this.ingredientes
    }
}

function Ingrediente(aName, aPrice) {
    this.nombre= aName;
    this.precio = aPrice;
}