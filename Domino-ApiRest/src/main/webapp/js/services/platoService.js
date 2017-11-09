'use strict';
dominoApp.service("platoService", PlatoRepo);


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

    this.setPlatoEnConstruccion = function (unPlato) {
        self.platosEnConstruccion.push(unPlato);
    };


}

