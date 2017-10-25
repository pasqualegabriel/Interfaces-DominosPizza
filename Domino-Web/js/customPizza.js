'use strict';

dominoApp.controller('pizzaSelectorCrl', function($state){


        /* scope */

        /* no pude hacer q utilize las pizzas del servicePizza FIJARSE*/
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

            $state.go("seleccionDeTamanio");

        };

    }
);

dominoApp.controller('sizeSelectorCrl', function (pizzaService) {


    return new SizeModel(pizzaService);


});

function SizeModel(pizzaService ){
        var aPrice= pizzaService.getPizzaByName("Muzza");
/*    if(aPrice===undefined){
        alert("Cagamos")
    }*/

    var x=aPrice.precio;

    this.tamanios=[
        new Tamanio("Porcion",x,0.125),
        new Tamanio("Chica",x,0.50),
        new Tamanio("Grande",x,1.00),
        new Tamanio("Familiar",x,1.25)
    ];

}

function Tamanio(aName,aPrice,aMultiplier){
    this.nombre=aName;
    this.precio= (aPrice * aMultiplier);


}


