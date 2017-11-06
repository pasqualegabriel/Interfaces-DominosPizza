'use strict';
dominoApp.service("sesionService", function ($http) {
    return new SesionRepo($http);


});

function SesionRepo($http) {

    var getData = function(response) { return new MiembroDTO(response.data)};
    var createLogin = function(nick,pass) { return new Login(nick, pass)};

    return {
        validate:  function (nick, pass) {
        return $http.post("/login", createLogin(nick,pass)).then(getData);
         }
    }

}


