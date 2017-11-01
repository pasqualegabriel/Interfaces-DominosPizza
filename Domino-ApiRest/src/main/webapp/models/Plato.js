function Plato(unaPizza,aID){

    var self = this;

    self.id                  = aID;
    self.pizza               = unaPizza;
    self.tamanio             = undefined;
    self.ingredientesExtras  = new DistribucionEnPizza();


    this.precioBaseDePizza = function(){
        return this.pizza.precioBase
    };

    this.getPrecioTotal =function(){
        return this.tamanio.precio+ this.precioDeIngredientesExtra()
    };

    this.precioDeIngredientesExtra =function(){
        var precios =  self.ingredientesExtras.ingredientes.map( function(unPairDeIngredientes){
            return unPairDeIngredientes.precio
        });

       var contador = 0;
        angular.forEach(precios, function (precio) {
            contador +=precio;
        });
        return contador;
    }
}