'use strict';
dominoApp.service("sesionService", function () {
    return new SessionRepo();
});

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
   /*
        return _.find(this.sesiones, function (aSesion) {
            return aSesion.nick === aNick;
        })
    */
    };

}

