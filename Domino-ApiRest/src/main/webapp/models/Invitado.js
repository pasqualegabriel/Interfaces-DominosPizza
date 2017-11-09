function Invitado() {
    var self = this;
    self.nombre= "Invitado";
    self.nick = "Invitado";

    this.getNick = function(){
        return self.nick
    };

    this.esUsuario = function()
    {
        return false;
    }
}