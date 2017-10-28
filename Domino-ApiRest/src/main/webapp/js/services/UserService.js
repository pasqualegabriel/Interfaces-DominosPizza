dominoApp.service("userService", function ($http) {
    return new UsuarioRepo($http);
});


function UsuarioRepo($http) {

    var getData     = function(response) { return response.data };
    var tranforme   =  function(json) { return new User(json) };
    return {
        query: function(aNick) {
            return $http.get("usuarios/" + aNick)
                .then(getData)
                .then(tranforme)},//posiblemente se vuele a la mierda
        validate: function(registro, cb, errorhandler) {
                return $http.post("/usuarios", registro).then(cb).catch(errorhandler)

        }
/*        update: function(libro, cb, errorHandler) { $http.put("libros/"+libro.id, libro).then(getData).then(cb).catch(errorHandler) },
        save: function(libro, cb, errorHandler) { $http.post("libros", libro).then(getData).then(cb).catch(errorHandler) },
        remove: function(libro, cb, errorHandler) { $http.delete("libros/"+libro.id).then(getData).then(cb).catch(errorHandler) }*/
    }
};

/*function UsuarioRepo(){

    this.usuarios =   [
        new User("pepita","g","1","pepita@gmail.com","callefalsa123"),
        new User("dionisia","golondrinaVieja","23asdfasdas","dionisia@gmail.com","callefalsa123")
    ];

    this.newUser = function (aName, aNick, aPassword, aMail, aDir) {

        var aNewUser = new User(aName,aNick,aPassword,aMail,aDir);
        this.addUser(aNewUser);
        return aNewUser;
    };

    this.addUser = function (aUser) {

        this.usuarios.push(aUser);
    };

    this.getUserByNick = function (aNick) {

        return _.find(this.usuarios, function (aUser) {
            return aUser.nick === aNick;
        })
    };
    this.getUserByMail=function(aMail){
        return _.find(this.usuarios,function (aUser) {
            return aUser.mail===aMail;
        })
    }*/


