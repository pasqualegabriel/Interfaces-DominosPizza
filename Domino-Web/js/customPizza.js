'use strict';

dominoApp.controller('SelectorPizzaCrl', function($stateParams,$state){


        /* scope */
        this.listaDePromos =
            [
                {
                    "nombre" : "Jamon",
                    "descripcion" : "muzzarela con jamon",
                    "precio" : 723.00
                },
                {
                    "nombre" : "Muzza",
                    "descripcion" : "muzzarela",
                    "precio" : 352.00
                },
                {
                    "nombre" : "Morron",
                    "descripcion" : "morrones",
                    "precio" : 132.00
                },
                {
                    "nombre" : "Anchoa",
                    "descripcion" : "anchoas",
                    "precio" : 722.00
                }
            ];


        this.seleccionar = function()
        {

            $state.go("editarPizza2");



        };

    }
);

dominoApp.controller('SeleccionDeTamañoCrl', function ($stateParams, $state) {

    this.tamanios=[
        {"nombre":"porcion","precio": $stateParams.precio},
        {"nombre":"chica","precio":  $stateParams.precio * 0.50},
        {"nombre":"grande","precio":  $stateParams.precio * 1.00},
        {"nombre":"familiar","precio":  $stateParams.precio * 1.25}

    ];



});


