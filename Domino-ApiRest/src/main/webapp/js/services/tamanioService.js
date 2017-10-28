'use strict';

dominoApp.service('tamanioService', function($http) {
    return new TamanioRepo($http);
});

function TamanioRepo($http){

    var transformSize       = function (json)       {return new Tamanio(json)};
    var getData             = function(response)    {return response.data};

    return{
        getTamanio: function () {
            return $http.get("/tamanios").then(getData).then(function (listJson) {
                    return listJson.map(transformSize)
                }

            )
        }
    }
}


