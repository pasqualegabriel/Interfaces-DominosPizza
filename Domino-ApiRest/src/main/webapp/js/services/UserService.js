dominoApp.service("userService", function ($http) {
    return new UserRepo($http);
});


function UserRepo($http) {
    var self= this;
    self.userLoggin=undefined;
    self.registrar  =new  Registrar($http);
    self.nuevosCambios = new NuevosCambios($http);

    this.setUserLoggin = function (aUser) {
        self.userLoggin= aUser;
    };

    this.getLoggedUserNick = function () {
      return self.userLoggin.getNick()
    };

    this.hayUsuarioLogeado = function(){
        return self.userLoggin !== undefined
    };

    this.registrarse=function (registro) {
        return self.registrar.registro(registro)
    };

    this.updateUser=function (user) {
        return self.nuevosCambios.update(user)
    }
}

function Registrar($http) {

    return {
        registro: function(registro) {
            return $http.post("/usuarios", registro);
        }
    }

}


function NuevosCambios($http) {

    return {
        update: function(user) {
            return $http.put("/usuarios/" + user.nick , user);
        }
    }

}

