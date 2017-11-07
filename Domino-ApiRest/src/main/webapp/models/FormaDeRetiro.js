function FormaDeRetiro(unTipo, unaDireccion, unPrecio){

    var self        = this;
    self.tipo       = unTipo;
    self.direccion  = unaDireccion;
    self.precio     = unPrecio;

    this.esDelivery = function () {
        return angular.equals(self.tipo, EnumFormaDeEnvio.Delivery);
    };

    this.tieneDireccion = function() {
        return angular.equals(self.tipo,EnumFormaDeEnvio.Local) || !angular.equals(self.direccion, "");

    };

    this.transformar = function(unJson){

        self.tipo   = unJson.tipo;
        self.precio = unJson.precio;
        if(angular.equals(unJson.tipo.toLowerCase(), "delivery"))
        {self.direccion= unJson.direccion; }
        return self;
    }



}
