'use strict';

dominoApp.controller('ListaPromosCrl',function(pedidosService, $state,$stateParams,ingredienteService) {
    return new ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService)

});


function ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService) {

    var self = this;

    this.pepita =function() {
        return $stateParams.id
    };

    self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion = self.pedido.searchPlato(self.pedido.idPlatoActual);

    this.pizza= self.platoEnConstruccion.pizza;
    this.nombreDePizza= this.pizza.nombre;

    this.tamanioDePlato= this.platoEnConstruccion.tamanio.nombre;


    this.precioTotalDelPlato= this.platoEnConstruccion.getPrecioTotal();
    /*
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
}
    var self= this;

    self.pepita = "Golondrina";
    //self.pedido = pedidosService.getPedidoEnContruccionById($stateParams.id);
    //self.platoEnConstruccion = self.pedido.searchPlato(self.pedido.idPlatoActual);

   // this.pizza= self.platoEnConstruccion.pizza;
    //this.nombreDePizza= this.pizza.nombre;

    //this.tamanioDePlato= this.platoEnConstruccion.tamanio;

/*
    this.precioTotalDelPlato= this.platoEnConstruccion.getPrecioTotal();

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


