'use strict';
dominoApp.service("pizzaService", function () {


    this.pizzas = [
        new Pizza("Muzza",100),
        new Pizza("Jamon Y Morron",150)
        //new Pizza("Cuatro quesos",200),
        //new Pizza("Anana",150)

    ];
/*    this.getPizzas=function () {
      return this.pizzas;
    };*/

/*
    this.newPizza= function (aName, aPost) {
        var aNewPizza= new Pizza(aName,aPost,"","");
        this.addPizza(aNewPizza);
        return aNewPizza;
    };

    this.addPizza=function (aPizza) {
        this.pizzas.push(aPizza);
    };*/

    this.getPizzaByName=function(aName){
        return _.find(this.pizzas,function (aPizza) {
            return aPizza.nombre===aName;
        })
    }



});

function Pizza(aName,aPost) {

    this.nombre         = aName;
    this.precio         = aPost;
    this.tamanio        = "";
    //this.distribucion   =[new PairIngredienteDistribucionPizza(aIng,aDir)];

/*    this.descripcion=function () {
        return this.nombre + this.distribucion.forEach(function (t) { t.ingrediente() });

    }*/
}

function PairIngredienteDistribucionPizza(aIng,aDir) {
    this.ingrediente    =aIng;
    this.distribucion   =aDir;

}