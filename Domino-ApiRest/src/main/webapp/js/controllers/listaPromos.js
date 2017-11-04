'use strict';

dominoApp.controller('ListaPromosCrl',function(pedidosService, $state,$stateParams,ingredienteService) {
    return new ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService)

});


function ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService) {

    var self = this;

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion = self.pedido.searchPlato(self.pedido.idPlatoActual);

    /*self.pizza= self.platoEnConstruccion.pizza;
    self.nombreDePizza= self.pizza.nombre;

    self.tamanioDePlato= self.platoEnConstruccion.tamanio.nombre;*/


    self.precioTotalDelPlato     = undefined;

    self.ingredientesAAgregar    = self.platoEnConstruccion.ingredientesExtras.ingredientes;
    self.ingredientesDeLaPizza   = self.platoEnConstruccion.pizza.distribucion.ingredientes;
    self.ingredientesDisponibles = undefined;
    self.ingredientesExtra       = undefined;

    this.nombreDePizza = function(){
        return self.platoEnConstruccion.pizza.nombre;
    };

    this.nombreDeTamanio = function(){
        return self.platoEnConstruccion.tamanio.nombre;
    };

    this.estaEnListaDeIngredientes = function (unaLista, unIngrediente) {
        return unaLista.some(function(pairDeIngEnPizza){ return pairDeIngEnPizza.esElIngrediente(unIngrediente)});
        //hacerle una funcion a
        //return unaLista.some(function(pairDeIngEnPizza){ return angular.equals( pairDeIngEnPizza.ingrediente.nombre, unIngrediente.nombre) } )
    };

    this.ingredientesExtraAAgregar = function(unaListaDeIngredientes) {

        var funcionDeFiltrado = function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesDeLaPizza, ingrediente) && !self.estaEnListaDeIngredientes(self.ingredientesAAgregar, ingrediente)};
        //Elegir buenos nombres
        /*var xx     = function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesDeLaPizza, ingrediente)};
        var xy     = function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesAAgregar, ingrediente)};

        var retorno = unaListaDeIngredientes.filter(xx);
        self.ingredientesExtra = retorno.filter(xy);*/
        self.ingredientesExtra = unaListaDeIngredientes.filter(funcionDeFiltrado);
    };

    this.calcularPrecio = function () {

        self.precioTotalDelPlato=self.platoEnConstruccion.calcularPrecioDeIngredientesAAgregar(self.ingredientesAAgregar);

    };


    // Por ahora lo dejamos que lo setee a los ingredientes disponibles aca, despues vemos si lo reutilizamos
    this.todosLosIngredientes = function(){
        ingredienteService.getAllIngredientes().then(function (listaDeIngredientes) {
                self.ingredientesDisponibles= listaDeIngredientes;
                return listaDeIngredientes;
            }).then(self.ingredientesExtraAAgregar)
    };




    this.agregarIngredienteExtra= function(unIngrediente){
        self.ingredientesAAgregar.push( new PairIngredienteDistribucionPizza(unIngrediente,""));
        self.ingredientesExtra = self.ingredientesExtra.filter(function(ingredienteExtra) {
            return angular.equals(ingredienteExtra.nombre, unIngrediente.nombre)
        });

        this.ingredientesExtraAAgregar(self.ingredientesDisponibles);
        this.calcularPrecio();
    };

    this.estaEnDistribucion= function(pairIng, distribucionNombre){
        return pairIng.tieneComoDistribucion(distribucionNombre)
    };


    this.quitarIngredienteExtra = function(unPairIngrediente){
        self.ingredientesExtra.push(unPairIngrediente.ingrediente);
        self.ingredientesAAgregar = self.ingredientesAAgregar.filter(function(otroPairIngrediente) {
            return !angular.equals(unPairIngrediente.ingrediente.nombre, otroPairIngrediente.ingrediente.nombre)
        });
        this.ingredientesExtraAAgregar(self.ingredientesDisponibles);
        this.calcularPrecio();
    };

    this.calcularPrecio();
    this.todosLosIngredientes();

    /*this.seleccionar = function()
    {

    };

    this.continuar = function() {
    }
}
    var self= this;

    self.pepita = "Golondrina";
    //self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    //self.platoEnConstruccion = self.pedido.searchPlato(self.pedido.idPlatoActual);

   // this.pizza= self.platoEnConstruccion.pizza;
    //this.nombreDePizza= this.pizza.nombre;

    //this.tamanioDePlato= this.platoEnConstruccion.tamanio;

/*
    this.precioTotalDelPlato= this.platoEnConstruccion.getCalcularPrecioConIngredientes();

    this.ingredientesDeLaPizza = this.pizza.distribucion.ingredientes;

    // esto es una lista de ingredientes, nada mas.
    this.ingredientesDisponibles= ingredientesService.getAllIngredientes();


    this.ingredientesAAgregar= function(){
      return  self.platoEnConstruccion.ingredientesExtras
    };


    this.ingredientesExtra= function() {
       var retorno= _.filter(this.ingredientesDisponibles, function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesDeLaPizza, ingrediente); });
       return _.filter(retorno, function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesAAgregar, ingrediente); })
    };

    this.estaEnListaDeIngredientes = function (unaLista, unIngrediente) {
          return _.some(unaLista, function(pairingrediente){ return pairingrediente.ingrediente === unIngrediente.nombre; } );
    };
*/

    /*this.seleccionar = function()
    {

    };

    this.continuar = function() {
    }
*/


}


