'use strict';
dominoApp.service("pizzaService", function () {
    return new PizzaRepo();
});


function PizzaRepo(){

    var pizza1 = new Pizza("Jamon" , "muzzarela con jamon"   , 125);
    var pizza2 = new Pizza("Morron", "muzzarela con morron"  , 175);
    var pizza3 = new Pizza("Anchoa", "muzzarela con anchoas" , 255);
    pizza1.addIngrediente  ( new Ingrediente("Jamon",33) ,"Toda");
    pizza2.addIngrediente  ( new Ingrediente("Jamon",33) ,"Izquierda");
    pizza2.addIngrediente  ( new Ingrediente("Morron",2) ,"Toda");
    pizza3.addIngrediente  ( new Ingrediente("Anchoa",2) ,"Toda");

    this.precioBase = 70;
    this.pizzas = [ pizza1, pizza2, pizza3 ];

    this.newPizza = function (aName, aPost) {
        var aNewPizza= new Pizza(aName,aPost);
        this.addPizza(aNewPizza);
        return aNewPizza;
    };

    this.addPizza=function (aPizza) {
        this.pizzas.push(aPizza);
    };

    this.getDistribucion = function (aPizza) {
        return aPizza.distribucion;
    };

    this.getPizzas = function () {
        return this.pizzas;
    };

    this.getPizzaByName = function (aName) {
        return _.find(this.pizzas, function (aPizza) {
            return aPizza.nombre === aName;
        })
    };


}

