'use strict';

dominoApp.config(function ($stateProvider, $urlRouterProvider) {


    $stateProvider

        .state('logIn',{
            url:"/ini",
            templateUrl: "../partials/iniciarSesion.html",
            controller: "SessionCrl as logIn"
        })

        .state('register', {
            url: "/reg",
            templateUrl: "../partials/registrarse.html",
            controller: "RegisterCrl as newUser"
        })

        .state('pizzaSelector', {
            url: "/ed/seleccionPizza/:id",
            templateUrl: "../partials/selectorDePizza.html",
            controller: "pizzaSelectorCrl as customPizza"
        })

        .state('seleccionDeTamanio', {
            url: "/ed/seleccionTamanio/:id",
            templateUrl: "../partials/selectorDeTamanio.html",
            controller: "sizeSelectorCrl as customSize"
        })

        .state('ingredientesExtras', {
            url: "/ed/customizarPedido/:id",
            templateUrl: "../partials/ingredientesExtras.html",
            controller: "ListaPromosCrl as promos"
        })

        .state('confirmarPedido', {
            url: "/ed/confirmarPedido/",
            templateUrl: "../partials/confirmarPedido.html",
            controller: "pedidosCtrl as pedido"
        });

    $urlRouterProvider.otherwise("/ini");

});
