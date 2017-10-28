function DistribucionEnPizza(listIngredientes) {

    self = this;
    self.listaLocal= [];

/*    this.addIngrediente = function (ingrediente) {
        this.ingredientes.push(new PairIngredienteDistribucionPizza(ingrediente.nombre,ingrediente.distribucion))
    };*/

    var list = function (listIngredientes) {
        //listIngredientes.map(this.addIngrediente)
        angular.forEach(listIngredientes,function (ingrediente) {
            self.listaLocal.push(new PairIngredienteDistribucionPizza(ingrediente.nombre,ingrediente.distribucion))
        });
        return self.listaLocal
    };

    this.ingredientes= list(listIngredientes);
}
