function PairIngredienteDistribucionPizza(aIng, aDir) {
    var self = this
    this.ingrediente     = aIng;
    this.distribucion    = aDir;

    this.tieneComoDistribucion = function(distribucionNombre){
        return angular.equals(this.distribucion,distribucionNombre);
    }

    this.precio= function () {
        return self.ingrediente
    }

}
