
function MiembroDTO(json) {
    return new Miembro(json.nombre, json.nick, json.password, json.mail, json.direccion);
}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion) {

    var self=this;
    self.nombre= unNombre;
    self.nick = unNick;
    self.password = unPassword;
    self.mail = unMail;
    self.direccion = unaDireccion;

    this.getNick = function () {
        return self.nick;
    };

    this.esUsuario = function()
    {
        return true;
    };

    this.realizarCambios = function (nombre,mail,direccion) {
        self.nombre    = nombre;
        self.mail      = mail;
        self.direccion = direccion;
    }


}
