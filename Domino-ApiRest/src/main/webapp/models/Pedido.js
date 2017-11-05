function Pedido(aIdMiembro){

    var self=this;



    self.idMiembro              = aIdMiembro;
    self.aclaracion             = "";
    self.formaDeRetiro          = undefined;
    self.monto                  = "";

    self.platoEnContruccion     = undefined;

    self.platosConfirmados      = [];


    this.setPlatoEnConstruccion = function (aPlato) {
        self.platoEnContruccion=aPlato;
    };


    this.belongsPlato= function (aId) {
        return _.some(self.platosConfirmados,function (plato){
            return angular.equals(plato.id,aId);
        });
    };


    this.confirmarPLato = function () {

        if(! self.belongsPlato(self.platoEnContruccion.id)){
            self.platosConfirmados.push(self.platoEnContruccion)
        }
    };

    this.eliminarPlato = function(plato){

        self.platosConfirmados.splice(self.platosConfirmados.indexOf(plato), 1);
    };

    this.setFormaDeEnvio = function (aFormaDeEnvio) {
        self.formaDeRetiro= aFormaDeEnvio;
    };

    this.costoTotalDelPedido = function(){

        if(self.platosConfirmados.length === 0 ){
            return 0;
        }else {
            return self.platosConfirmados
                .map(function (unPlato)
                    { return unPlato.getCalcularPrecioConIngredientes() }
                )
                .reduce(function (total, numero)
                    { return total + numero; }
                )// Es como el sum de java
        }
    };

}


