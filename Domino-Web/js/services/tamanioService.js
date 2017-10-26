'use strict';

dominoApp.service('tamanioService', function() {
    return new TamanioRepo();
});

function TamanioRepo(){

    this.tamanios =
        [   new Tamanio("Porcion",0.125 ), new Tamanio("Chica",0.50),
            new Tamanio("Grande",1.00), new Tamanio("Familiar",1.25)
        ];

    this.getAll = function () {
        return this.tamanios;
    }
}


function Tamanio(aName, aFactor) {
    this.nombre             = aName;
    this.factorDeTamanio    = aFactor;

}