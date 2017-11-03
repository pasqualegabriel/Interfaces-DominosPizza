function Pedido(aIdMiembro){

    var self=this;

    self.idMiembro           = aIdMiembro;

    // esto deberia estar en un service
    self.platosEnConstruccion              = [];
    self.platosConfirmados   = [];


    self.aclaracion          = "";
    self.formaDeRetiro       = new FormaDeRetiro("","");
    self.monto               = "";
    self.idPlatoActual       = "";

    this.addPlatoEnConstruccion = function (aPlato) {
        self.platosEnConstruccion.push(aPlato);
    };

    this.setIdPlatoActual= function (aId) {
        self.idPlatoActual=aId;
    };


    this.searchPlato= function (aId) {
        return _.find(self.platosEnConstruccion,function (plato){
            return angular.equals(plato.id,aId);/* === aId;*/
        });
    };

}


