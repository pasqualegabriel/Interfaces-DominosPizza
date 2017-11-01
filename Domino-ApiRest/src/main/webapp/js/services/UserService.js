dominoApp.service("userService", function ($http) {
    return new UsuarioRepo($http);
});


function UsuarioRepo($http) {



    return {
        validate: function(registro) {
                return $http.post("/usuarios", registro)
        }
    }
}
