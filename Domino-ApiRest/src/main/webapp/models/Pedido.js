function Pedido(aIdMiembro){

    var self=this;

    self.idMiembro      = aIdMiembro;
    self.platos         = [];
    self.aclaracion     = "";
    self.formaDeRetiro  = new FormaDeRetiro("","");
    self.monto          = "";
    self.idPizzaActual  = "";

    this.addPlato = function (aPlato) {
        self.platos.push(aPlato);

    };

    this.setIdPizzaActual= function (aId) {
        self.idPizzaActual=aId;
    };

    this.searchPizza = function (aId) {
        return _.find(self.platos,function (plato){
            return angular.equals(plato.pizza.nombre,aId);/* === aId;*/
        });
    };

    this.searchTamanio =function (aTamanio) {
        return _.find(self.platos,function (aPlato) {
            return aPlato.tamanio === aTamanio;
        })

    }

}


