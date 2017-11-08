function FormaDeRetiro(unTipo, unaDireccion, unPrecio){

    var self        = this;
    self.tipo       = unTipo;
    self.direccion  = unaDireccion;
    self.precio     = unPrecio;

    this.esDelivery = function () {
        return angular.equals(this.tipo, "Delivery")

    };

    this.esLocal = function () {
        return angular.equals(this.tipo, "Local")
    };

    this.direccionValida = function()
    {
        return angular.equals(self.tipo,EnumFormaDeEnvio.Local) || !angular.equals(self.direccion, "");//self.esLocal() || !angular.equals(this.direccion,"");

    };

    this.getDireccion = function () {
        if(self.direccion.length === 0){
            return "Retiro por Local";
        }
        else {
            return self.direccion;
        }
    };

/*
    this.tieneDireccion = function() {
        return angular.equals(self.tipo,EnumFormaDeEnvio.Local) || !angular.equals(self.direccion, "");

    };
*/



}

function HidratarFormaDeRetiro() {
    this.tranform=function (unJson) {
        var newFormaDeRetiro= new FormaDeRetiro("","",0);
        newFormaDeRetiro.tipo   = unJson.tipo;
        newFormaDeRetiro.precio = unJson.precio;
        if(angular.equals(unJson.tipo.toLowerCase(), "delivery"))
        {newFormaDeRetiro.direccion= unJson.direccion; }
        return newFormaDeRetiro;
    }
}
