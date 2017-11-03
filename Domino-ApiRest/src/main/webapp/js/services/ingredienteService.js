'use strict';
dominoApp.service("ingredienteService", function ($http) {
    return new IngredienteRepo($http);
});


function IngredienteRepo($http){
    var getData                   = function(response) { return response.data };
    var transformIngredientes     = function(json)        {return new IngredienteDTO(json)};

    return {
        getAllIngredientes: function() {
            return $http.get("/ingredientes").then(getData).then(function(listJson){
                return listJson.map(transformIngredientes)
            })
        }
    }
}


