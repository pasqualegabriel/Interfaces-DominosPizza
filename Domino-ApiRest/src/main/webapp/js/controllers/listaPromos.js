'use strict';

dominoApp.controller('ListaPromosCrl',function(pedidosService, $state,$stateParams,ingredienteService) {
    return new ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService)

});


function ModelListaPromo(pedidosService, $state,$stateParams,ingredienteService) {

    var self                     = this;

    self.pedido                  = pedidosService.getPedidoEnContruccionById($stateParams.id);
    self.platoEnConstruccion     = self.pedido.platoEnContruccion;
    self.ingredientesDeLaPizza   = self.platoEnConstruccion.pizza.distribucion.ingredientes;
    self.ingredientesDisponibles = undefined;
    self.ingredientesExtra       = undefined;

    this.errorHandler = function (error) {
        alert(error.data.error)
    };

    this.nombreDePizza = function(){
        return self.platoEnConstruccion.nombreDePizza();
    };

    this.nombreDeTamanio = function(){
        return self.platoEnConstruccion.nombreTamanio();
    };

    this.estaEnListaDeIngredientes = function (unaLista, unIngrediente) {
        return unaLista.some(function(pairDeIngEnPizza){ return pairDeIngEnPizza.esElIngrediente(unIngrediente)});
    };

    this.ingredientesExtraAAgregar = function(unaListaDeIngredientes) {

        var funcionDeFiltrado = function(ingrediente){ return !self.estaEnListaDeIngredientes(self.ingredientesDeLaPizza, ingrediente) && !self.estaEnListaDeIngredientes(self.platoEnConstruccion.ingredientesExtraConDist(), ingrediente)};
        self.ingredientesExtra = unaListaDeIngredientes.filter(funcionDeFiltrado);
    };

    this.calcularPrecio = function () {
        return self.platoEnConstruccion.getCalcularPrecioConIngredientes();
    };



    this.todosLosIngredientes = function(){
        ingredienteService.getAllIngredientes().then(function (listaDeIngredientes) {
                self.ingredientesDisponibles= listaDeIngredientes;
                return listaDeIngredientes;
            }).then(self.ingredientesExtraAAgregar).catch(self.errorHandler)
    };


    this.agregarIngredienteExtra= function(unIngrediente){
        self.platoEnConstruccion.agregarIngredienteExtra(new PairIngredienteDistribucionPizza(unIngrediente,""));
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
        self.platoEnConstruccion.quitarIngredienteExtra(unPairIngrediente);
        this.ingredientesExtraAAgregar(self.ingredientesDisponibles);
        this.calcularPrecio();
    };

    this.finalizarPlato= function () {
        self.pedido.confirmarPLato();
        $state.go("confirmarPedido",{id: $stateParams.id});
    };

    this.calcularPrecio();
    this.todosLosIngredientes();

}


