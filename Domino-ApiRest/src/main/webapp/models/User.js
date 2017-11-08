
function MiembroDTO(json) {
    return new Miembro(json.nombre, json.nick, json.password, json.mail, json.direccion);
}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion) {


    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;

    this.getNick = function () {
        return this.nick;
    };

}
