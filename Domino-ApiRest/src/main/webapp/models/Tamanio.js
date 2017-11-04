function Tamanio(json) {

    var self = this;

    self.nombre             = json.nombre;
    self.factorDeTamanio    = json.factorDeTamanio;
    self.precio             = "";

//    this.aplicarFactorDeTamanio= function (precio) {
//
//        self.precio =   precio * self.factorDeTamanio;
//    };

    this.calcularPrecioPorTamanio= function (precio)
    {
        return precio * self.factorDeTamanio;
    };

}
