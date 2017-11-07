dominoApp.service("userService", function () {
    return new UserRepo();
});


function UserRepo() {
    var self= this;
    self.userLoggin=undefined;

    this.setUserLoggin = function (aUser) {
        self.userLoggin= aUser;
    };

    this.getLoggedUserNick = function () {
      return self.userLoggin.getNick()
    };

    this.hayUsuarioLogeado = function(){
        return self.userLoggin !== undefined
    }
}
