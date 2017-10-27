dominoApp.service("userService2", function ($http) {
    return new UsuarioRepo2();
});



function UsuarioRepo2(){

    this.usuarios =   [];

    this.getUserByNick = function (aNick) {
        $http.get("/usuarios/" + aNick).then(function (response) {
            alert(response.data);
        });

    };


    this.newUser = function (aName, aNick, aPassword, aMail, aDir) {

        var aNewUser = new User(aName,aNick,aPassword,aMail,aDir);
        this.addUser(aNewUser);
        return aNewUser;
    };

    this.addUser = function (aUser) {

        this.usuarios.push(aUser);
    };

    this.getUserByMail=function(aMail){
        return _.find(this.usuarios,function (aUser) {
            return aUser.mail===aMail;
        })
    }
}
function Usuario2(json){

    angular.ex

}