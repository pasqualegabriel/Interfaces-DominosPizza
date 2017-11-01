'use strict';
dominoApp.service("pizzaService", function ($http) {
    return new PizzaRepo($http);
});


function PizzaRepo($http){
    var transformPizza      = function(json)        {return new PizzaDTO(json)};
    var getData             = function(response)    {return response.data};


    return{
        getPizzas: function () {
         return $http.get("/pizzas").then(getData).then(function(listJson){
             return listJson.map(transformPizza)
         })},
         getPrecioBase : function () {
                return $http.get("/precioBase").then(getData)
            }
        }
}






