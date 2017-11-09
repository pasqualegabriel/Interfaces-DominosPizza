'use strict';

dominoApp.controller('ListaPromosCrl', ControllerListaPromo);


function ControllerListaPromo(pedidosService, $state, ingredienteService,messageHandler) {

    var self                     = this;
    /* Atributos */

    self.pedido                  = pedidosService.getPedidoActual();
    self.platoEnConstruccion     = self.pedido.platoEnConstruccion;


    self.ingredientesDeLaPizza   = self.platoEnConstruccion.getIngredientesDePizza();

    self.ingredientesDisponibles = undefined;
    self.ingredientesExtra       = undefined;


    this.nombreDePizza = function(){
        return self.platoEnConstruccion.nombreDePizza();
    };

    this.nombreDeTamanio = function(){
        return self.platoEnConstruccion.nombreTamanio();
    };


    this.ingredientesExtraAAgregar = function(unaListaDeIngredientes) {

       var funcionDeFiltrado = function(ingrediente){ return !ingrediente.estaEnLista(self.ingredientesDeLaPizza) && !ingrediente.estaEnLista(self.platoEnConstruccion.ingredientesExtraConDist())};

        self.ingredientesExtra = unaListaDeIngredientes.filter(funcionDeFiltrado);
    };

    this.calcularPrecio = function () {
        return self.platoEnConstruccion.getCalcularPrecioConIngredientes();
    };



    this.todosLosIngredientes = function(){
        ingredienteService.getAllIngredientes().then(function (listaDeIngredientes) {
                self.ingredientesDisponibles= listaDeIngredientes;
                return listaDeIngredientes;
            }).then(self.ingredientesExtraAAgregar).catch(function(response){messageHandler.notificarError(response.data.error)})
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
       try {
           self.pedido.confirmarPLato();
           $state.go("confirmarPedido");
       }
       catch (e){
           var error= "Por favor seleccione la distribucion de todos los ingredientes Extra";
           messageHandler.notificarError(error)
       }
    };

    this.calcularPrecio();
    this.todosLosIngredientes();

}


