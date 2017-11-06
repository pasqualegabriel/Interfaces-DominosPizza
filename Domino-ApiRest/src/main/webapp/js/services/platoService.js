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


    // Deberia el Cliente tener la responsabilidad de setear el id de un plato?
    // No deberia ser el servidor quien lo haga?
    // MMMMMMMMMMMmm, fijarse si hay alternativa despues cuando ande todo.
    this.newPlato = function (unaPizza) {
        var nuevoPLato= new Plato(unaPizza,self.lastId);
        this.nextId();
        return nuevoPLato;
    };

    this.setPlatoEnConstruccion = function (unPlato) {
        self.platosEnConstruccion.push(unPlato);
    };


}

