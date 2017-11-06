function Pedido(aIdMiembro){

    var self=this;



    self.idMiembro              = aIdMiembro;
    self.aclaracion             = "";
    self.formaDeRetiro          = undefined;
    self.monto                  = "";

    self.platoEnConstruccion     = undefined;

    self.platosConfirmados      = [];


    this.setPlatoEnConstruccion = function (aPlato) {
        self.platoEnConstruccion=aPlato;
    };

    this.platoEsValido = function (plato) {
      return plato.todosLosIngredientesCompletos();
    };

    //Cambio
    // Antes se fijaba que no estaba el plato ya en la lista de pedidos a confirmar
    // Pero no va a llegar nunca a estar ahi sin que se confirme el plato
    // Cambie la confirmacion a Plato es valido, que se fija si si todos los ingredientes estan completos
    // y si no lo estan, levanta una excepcion.

    this.confirmarPLato = function () {

        if(self.platoEsValido(self.platoEnConstruccion)){
            self.platosConfirmados.push(self.platoEnConstruccion)
        }
        else{
            throw "Faltan Completar Ingredientes"
        }
    };

    this.eliminarPlato = function(plato){

        self.platosConfirmados.splice(self.platosConfirmados.indexOf(plato), 1);
    };

    this.setFormaDeEnvio = function (aFormaDeEnvio) {
        self.formaDeRetiro= aFormaDeEnvio;
    };

    this.costoTotalDelPedido = function(tipoDeFormaDeEnvio){

        if(self.platosConfirmados.length === 0 ){
            return 0;
        }else {
            return self.platosConfirmados
                .map(function (unPlato)
                    { return unPlato.getCalcularPrecioConIngredientes() }
                )
                .reduce(function (total, numero)
                    { return total + numero; }
                )
                    + tipoDeFormaDeEnvio.precio
        }
    };

}


function PedidoDTO(unPedido){
    var self=this;


    // Hacer que el api Setee el id del otro lado.
    self.id                     = 0;
    self.estadoActual           = "Preparando";
    self.miembro                = unPedido.idMiembro;
    self.platosEnConstruccion   = unPedido.platosConfirmados ;
    //Cambiar Fecha.
    self.fecha                  = "2017-09-10";
    self.aclaracion             = unPedido.aclaracion;
    self.formaDeRetiro          = unPedido.formaDeRetiro;
    self.monto                  = unPedido.monto;
    self.tiempoDeEspera         = 0;

}
