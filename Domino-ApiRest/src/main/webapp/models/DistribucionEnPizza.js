function DistribucionEnPizza(listIngredientes) {

    var self = this;



    var list = function (listIngredientes) {
        var listaLocal= [];
        angular.forEach(listIngredientes,function (lisDistribucion) {
            var nombreIng= lisDistribucion.ingrediente.nombre;
            var precioIng= lisDistribucion.ingrediente.precio;
            listaLocal.push(new PairIngredienteDistribucionPizza(new Ingrediente(nombreIng,precioIng),lisDistribucion.distribucion))
        });
        return listaLocal
    };

    self.ingredientes= list(listIngredientes);

    this.agregarParIngDist = function(unParIngDist) {
        self.ingredientes.push(unParIngDist);
    };

    this.quitarParIngDist = function(unParIngDistAQuitar) {
        self.ingredientes = self.ingredientes.filter(function(otroPairIngrediente) {
            return !angular.equals(unParIngDistAQuitar.ingrediente.nombre, otroPairIngrediente.ingrediente.nombre)
        });
    };

    this.listarNombreIngrediente= function () {
      return self.ingredientes.map(function(parIngDist){ return parIngDist.nombreDeIngrediente()})
    };

    this.tamanio=function () {
        return self.ingredientes.length
    };

    this.todosLosIngredientesCompletos =function(){
        return self.ingredientes.every(function(pairIngDist){ return pairIngDist.tieneDistribucion()})
    }

}
