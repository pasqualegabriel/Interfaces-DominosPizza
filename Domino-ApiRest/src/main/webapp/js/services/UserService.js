dominoApp.service("userService", UserRepo);


function UserRepo($http) {
    var self                = this;
    self.userLoggin         = undefined;
    self.registrar          = new  Registrar($http);
    self.nuevosCambios      = new NuevosCambios($http);

    this.setUserLoggin = function (aUser) {
        self.userLoggin= aUser;
    };

    this.getLoggedUserNick = function () {
      return self.userLoggin.getNick()
    };

    this.logOut = function () {
        self.userLoggin = undefined;
    };

    this.hayUsuarioLogeado = function(){
        return self.userLoggin !== undefined
    };

    this.registrarse=function (registro) {
        return self.registrar.registro(registro)
    };

    this.updateUser=function (user) {
        return self.nuevosCambios.update(user)
    };

    this.nuevoInvitado = function(){
        return new Invitado;
    };

    this.esUsuarioRegistrado = function()
    {
        return !angular.isUndefined(self.userLoggin) && self.userLoggin.esUsuario();

    };

    this.newUser=function (nombre, nick, pass, mail, direccion) {
        return new Miembro(nombre, nick, pass, mail, direccion, []);
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

