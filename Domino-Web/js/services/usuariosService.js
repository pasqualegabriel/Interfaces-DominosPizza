'use strict';
dominoApp.service("userService", function () {
    return new UsuarioRepo();
});

function UsuarioRepo(){

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
    }
}

