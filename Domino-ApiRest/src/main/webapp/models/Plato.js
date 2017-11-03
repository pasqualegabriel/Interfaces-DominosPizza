function Plato(unaPizza,aID){

    var self = this;

    self.id                  = aID;
    self.pizza               = unaPizza;
    self.tamanio             = undefined;
    self.ingredientesExtras  = new DistribucionEnPizza();


    this.precioBaseDePizza = function(){
        return this.pizza.precioBase
    };

    this.calcularPrecioDeIngredientesAAgregar = function(listaIngAAgregar) {
        if(listaIngAAgregar.length === 0 ){
            return  0
        }else{
            var lista = [];
            listaIngAAgregar.copyWithin(lista);
            var x = lista.shift().precio();
            alert(x);
            return  x + this.calcularPrecioDeIngredientesAAgregar(lista);
        }
    };

    this.getCalcularPrecioConIngredientes =function(listaIngAAgregar){
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