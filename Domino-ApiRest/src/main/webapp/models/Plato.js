function Plato(unaPizza,aID){

    var self = this;

    self.id                  = aID;
    self.pizza               = unaPizza;
    self.tamanio             = undefined;
    self.ingredientesExtras  = new DistribucionEnPizza([]);

    this.getId=function () {
        return self.id;
    };

    this.getIngredientesDePizza = function (){
        return self.pizza.getIngredientes()
    };

    this.calcularPrecioConTamanio = function (aSize) {
        return aSize.calcularPrecioPorTamanio(self.precioBaseDePizza());
    };

    this.precioBaseDePizza = function(){
        return this.pizza.precioBase
    };

    this.getCalcularPrecioConIngredientes =function(){
        return self.tamanio.calcularPrecioPorTamanio(self.pizza.precioBase) + self.calcularPrecioDeIngredientesAAgregar();
    };
    this.calcularPrecioDeIngredientesAAgregar = function() {
        if(self.ingredientesExtraConDist().length === 0 ){
            return 0;
        }else {
            return self .ingredientesExtraConDist()
                        .map(function (parIngDist)
                            { return parIngDist.precio() }
                            )
                         .reduce(function (total, numero)
                                { return total + numero; }
                                )// Es como el sum de java
        }
    };

    this.agregarIngredienteExtra = function(unParIngDist) {
        self.ingredientesExtras.agregarParIngDist(unParIngDist);
    };

    this.quitarIngredienteExtra = function(unParIngDist) {
        self.ingredientesExtras.quitarParIngDist(unParIngDist);
    };

    this.nombreDePizza = function()
    {   return self.pizza.nombre;   };

    this.nombreTamanio = function()
    {   return self.tamanio.nombre;   };

    this.ingredientesExtraConDist = function()
    {   return self.ingredientesExtras.ingredientes;   };

    this.ingredientePizza = function () {
        return self.pizza.listaDeNombresIngredientes();
    };

    this.nombreDeIngredientes = function(){

        var listaDeNombres = self.pizza.distribucion.listarNombreIngrediente().concat(self.ingredientesExtras.listarNombreIngrediente());
        if ( listaDeNombres.length > 1  ) {
            var ultimoElemento = listaDeNombres.pop();

            return listaDeNombres.join(", ") + " y " + ultimoElemento
        }else{
            return listaDeNombres.toString()
        }
    };

    this.todosLosIngredientesCompletos= function(){
      return  this.ingredientesExtras.todosLosIngredientesCompletos()
    };



}

function PlatoDTO(aPlato){

    this.pizza               = new PizzaDTO(aPlato.pizza);
    this.tamanio             = new Tamanio(aPlato.tamanio);
    this.ingredientesExtras  = aPlato.ingredientesExtras;
}

function HidratadorDePlato() {

    this.tranform =function (json,nick) {
        var newPLato= new Plato(new PizzaDeAPI(json.pizza),nick);
        newPLato.tamanio= new Tamanio(json.tamanio);
        newPLato.ingredientesExtras=new DistribucionEnPizza(json.ingredientesExtras.ingredientes);

        return newPLato;
    }
}