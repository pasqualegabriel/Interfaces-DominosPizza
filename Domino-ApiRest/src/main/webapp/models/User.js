
function MiembroDTO(json) {
    return new Miembro(json.nombre, json.nick, json.password, json.mail, json.direccion, json.historialDePedidos);
}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion, unHistorialDePedidos) {


    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;
    this.historialDePedidos = unHistorialDePedidos.map(function (t) { return new PedidoDeApi(t) });

    this.getNick = function () {
        return this.nick;
    };

}
