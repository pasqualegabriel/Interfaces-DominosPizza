function DistribucionEnPizza(listIngredientes) {

    var self = this;



    var list = function (listIngredientes) {
        var listaLocal= [];
        angular.forEach(listIngredientes,function (lisDistribucion) {
            var nombreIng= lisDistribucion.ingrediente.nombre;
            var precioIng= lisDistribucion.ingrediente.precio;
            //self.listaLocal.push(new PairIngredienteDistribucionPizza(new Ingrediente(nombreIng,precioIng),lisDistribucion.distribucion))
            listaLocal.push(new PairIngredienteDistribucionPizza(new Ingrediente(nombreIng,precioIng),lisDistribucion.distribucion))
        });
        //return self.listaLocal
        return listaLocal
    };

    this.ingredientes= list(listIngredientes);

    this.agregarParIngDist = function(unParIngDist) {
        self.ingredientes.push(unParIngDist);
    };

    this.quitarParIngDist = function(unParIngDistAQuitar) {
        self.ingredientes = self.ingredientes.filter(function(otroPairIngrediente) {
            return !angular.equals(unParIngDistAQuitar.ingrediente.nombre, otroPairIngrediente.ingrediente.nombre)
        });
    }
}
