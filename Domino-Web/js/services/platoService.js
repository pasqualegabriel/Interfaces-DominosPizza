'use strict';
dominoApp.service("platoService", function () {
    return new PlatoRepo();
});


function PlatoRepo(){
    this.platos =   [
    ];

    this.newPlato = function (unaPizza) {
        var newPlato = new Plato(unaPizza);
        return newPlato;
    };

    this.addPlato = function (unPlato) {
        this.platos.push(unPlato);
    };
}
