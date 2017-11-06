function FormaDeRetiro(unTipo, unaDireccion, unPrecio){
    this.tipo       = unTipo;
    this.direccion  = unaDireccion;
    this.precio     = unPrecio;

    this.esDelivery = function () {
        return angular.equals(this.tipo, "Delivery")
    }

}
