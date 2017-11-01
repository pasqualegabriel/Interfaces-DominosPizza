'use strict';
dominoApp.service("sesionService", function ($http) {
    return new SessionRepo($http);


});

function SessionRepo($http) {

    var getData = function(response) { return new MiembroDTO(response.data)};


    return {
        validate:  function (login) {
        return $http.post("/login", login).then(getData);
         }
    }

}


