function FormaDeRetiro(unTipo, unaDireccion, unPrecio){

    var self        = this;
    self.tipo       = unTipo;
    self.direccion  = unaDireccion;
    self.precio     = unPrecio;

    this.esDelivery = function () {
        return angular.equals(this.tipo, "Delivery")
        //return angular.equals(self.tipo, EnumFormaDeEnvio.Delivery);
    };

    this.esLocal = function () {
        return angular.equals(this.tipo, "Local")
    };

    this.direccionValida = function()
    {
        return self.esLocal() || !angular.equals(this.direccion,"");
       /* if(this.esLocal())
        {   return true }
        else
        {   return !angular.equals(this.direccion,""); }*/
    };

    this.getDireccion = function () {
        if(self.direccion.length === 0){
            return "Retiro por Local";
        }
        else {
            return self.direccion;
        }
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
