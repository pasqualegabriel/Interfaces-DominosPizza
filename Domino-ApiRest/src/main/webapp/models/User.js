function MiembroDTO(json) {


    this.nombre= json.nombre;
    this.nick = json.nick;
    this.password = json.password;
    this.mail = json.mail;
    this.direccion = json.direccion;
    this.historialDePedidos = json.historialDePedidos;

}

function Miembro(unNombre, unNick, unPassword, unMail, unaDireccion) {


    this.nombre= unNombre;
    this.nick = unNick;
    this.password = unPassword;
    this.mail = unMail;
    this.direccion = unaDireccion;
    this.historialDePedidos = [];

}
