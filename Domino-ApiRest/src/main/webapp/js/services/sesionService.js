'use strict';
dominoApp.service("sesionService", function ($http) {
    return new SessionRepo($http);


});

function SessionRepo($http) {

    var getData = function(response) { return new User(response.data)};

    return {
        validation: function (login, cb, errorhandler) {
            return $http.post("/login", login).then(getData).then(cb).catch(errorhandler)
        }
    }

}

function Error2(json) {
    angular.extend(this, json);
}

/*
function SessionRepo(){

    this.sesiones =   [
    ];

    this.newSesion = function (aUser) {
        var aSesion =  this.getSesionByNick(aUser.nick);
        if (aSesion === undefined){
            var aNewSesion = new Sesion(aUser);
            this.addSesion(aNewSesion);
            return aNewSesion;
        }
        else {
            return aSesion
        }
    };

    this.addSesion = function (aSesion) {
        this.sesiones.push(aSesion);
    };

    this.getSesionByNick = function (aNick) {
        userService2.getUserByNick(aNick);

        return _.find(this.sesiones, function (aSesion) {
            return aSesion.nick === aNick;
        })

    };
    */



