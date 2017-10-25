'use strict';

dominoApp.config(function ($stateProvider, $urlRouterProvider) {


    $stateProvider

        .state('iniciarSesion',{
            url:"/ini",
            templateUrl: "../partials/iniciarSesion.html",
            controller: "SesionCrl as sesion"
        })

        .state('registrarse', {
            url: "/reg",
            templateUrl: "../partials/registrarse.html",
            controller: "RegistrarseCrl as usuario"
        })

        .state('seleccionDePizza', {
            url: "/ed/seleccionPizza",
            templateUrl: "../partials/selectorDePizza.html",
            controller: "SelectorPizzaCrl as selectCrl"
        })

        .state('seleccionDeTamanio', {
            url: "/ed/seleccionTamanio",
            templateUrl: "../partials/selectorDeTamanio.html",
            controller: "SeleccionDeTamañoCrl as selectCrl"
        });

    $urlRouterProvider.otherwise("/ini");

});
