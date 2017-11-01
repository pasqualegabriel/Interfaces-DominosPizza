'use strict';
dominoApp.service("platoService", function () {
    return new PlatoRepo();
});


function PlatoRepo(){
    var self = this;
    self.platosEnConstruccion = [];
    self.lastId = 0 ;

    this.nextId=function () {
        self.lastId ++
    };

    this.newPlato = function (unaPizza) {
        var nuevoPLato= new Plato(unaPizza,self.lastId);
        this.nextId();
        return nuevoPLato;
    };

    this.addPlatoEnConstruccion = function (unPlato) {
        self.platosEnConstruccion.push(unPlato);
    };


}

