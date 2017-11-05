function MiembroDTO(json) {

    var self = this;
    self.nombre= json.nombre;
    self.nick = json.nick;
    self.password = json.password;
    self.mail = json.mail;
    self.direccion = json.direccion;
    self.historialDePedidos = json.historialDePedidos;

    this.getNick = function () {
        return self.nick;
    }

}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion) {


    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;
    this.historialDePedidos = [];

}
