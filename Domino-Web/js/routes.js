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
            url: "/ed/seleccionPizza",
            templateUrl: "../partials/selectorDePizza.html",
            controller: "pizzaSelectorCrl as customPizza"
        })

        .state('seleccionDeTamanio', {
            url: "/ed/seleccionTamanio",
            templateUrl: "../partials/selectorDeTamanio.html",
            controller: "sizeSelectorCrl as customSize"
        });

    $urlRouterProvider.otherwise("/ini");

});
