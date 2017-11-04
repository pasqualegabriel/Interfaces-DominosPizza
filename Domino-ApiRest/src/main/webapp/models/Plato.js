function Plato(unaPizza,aID){

    var self = this;

    self.id                  = aID;
    self.pizza               = unaPizza;
    self.tamanio             = undefined;
    self.ingredientesExtras  = new DistribucionEnPizza();


    this.precioBaseDePizza = function(){
        return this.pizza.precioBase
    };

    this.calcularPrecioDeIngredientesAAgregar = function() {
        if(self.ingredientesExtraConDist().length === 0 ){
            return 0;
        }else {
            return self.ingredientesExtraConDist().map(function (parIngDist) {
                return parIngDist.precio()}).reduce(function (total, numero) {
                return total + numero;
            })
        }
        /*if(listaIngAAgregar.length === 0 ){
            return  0
        }else{
            var lista = listaIngAAgregar.copyWithin(lista);
            var x = lista.shift().precio();
            return  x + this.calcularPrecioDeIngredientesAAgregar(lista);
        }*/
    };

    this.agregarIngredienteExtra = function(unParIngDist) {
        self.ingredientesExtras.agregarParIngDist(unParIngDist);
    };

    this.quitarIngredienteExtra = function(unParIngDist) {
        self.ingredientesExtras.quitarParIngDist(unParIngDist);
    };

    this.getCalcularPrecioConIngredientes =function(){
        return self.tamanio.calcularPrecioPorTamanio(self.pizza.precioBase) + self.calcularPrecioDeIngredientesAAgregar();
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
    };

    this.nombreDePizza = function()
    {   return self.pizza.nombre;   };

    this.nombreTamanio = function()
    {   return self.tamanio.nombre;   };

    this.ingredientesExtraConDist = function()
    {   return self.ingredientesExtras.ingredientes;   };
}