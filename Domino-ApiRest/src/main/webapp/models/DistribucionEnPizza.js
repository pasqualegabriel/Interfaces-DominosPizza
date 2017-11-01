function DistribucionEnPizza(listIngredientes) {

    var self = this;
    self.listaLocal= [];


    var list = function (listIngredientes) {

        angular.forEach(listIngredientes,function (lisDistribucion) {
            var nombreIng= lisDistribucion.ingrediente.nombre;
            var precioIng= lisDistribucion.ingrediente.precio;
            self.listaLocal.push(new PairIngredienteDistribucionPizza(new Ingrediente(nombreIng,precioIng),lisDistribucion.distribucion))
        });
        return self.listaLocal
    };

    this.ingredientes= list(listIngredientes);
}
