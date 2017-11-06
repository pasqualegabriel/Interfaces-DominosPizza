
function MiembroDTO(json) {

    // Cambio:
    // El miembroDTO es solo un DTO. Estaba remplazando el lugar de miembro.

    //Antes ->

    /*
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
    */

    //Ahora ->
    return new Miembro(json.nombre, json.nick, json.password, json.mail, json.direccion, json.historialDePedidos);


}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion, unHistorialDePedidos) {


    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;
    this.historialDePedidos = unHistorialDePedidos;

    this.getNick = function () {
        return this.nick;
    };
}
