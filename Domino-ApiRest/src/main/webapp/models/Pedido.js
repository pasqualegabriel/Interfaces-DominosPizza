function Pedido(aIdMiembro){

    var self=this;



    self.idMiembro              = aIdMiembro;
    self.aclaracion             = "";
    self.formaDeRetiro          = new FormaDeRetiro("", "", 0);
    //self.formaDeRetiro          = undefined;
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
                    + self.formaDeRetiro.precio
                    //+ tipoDeFormaDeEnvio.precio
        }
    };

    this.hayFormaDeEnvio = function(){
        return self.formaDeRetiro.esLocal() || self.formaDeRetiro.esDelivery()
    };
}


function PedidoDTO(unPedido){

    var self=this;

    self.miembro        = unPedido.idMiembro;
    self.platos         = unPedido.platosConfirmados.map(function (t) { return new PlatoDTO(t)});
    self.aclaracion     = unPedido.aclaracion;
    self.formaDeRetiro  = unPedido.formaDeRetiro;

/*
    this.tranformPLatoDTO=function (aPLato){
        return new PlatoDTO(aPLato);
    }
*/

}

function PedidoDeApi(json){

    var self=this;



    self.miembro                = json.id;
    self.platosEnConstruccion   = json.platos.map(function (t) { return new Plato(new PizzaDeAPI(t.pizza),self.miembro).tranform(t)});
    self.aclaracion             = json.aclaracion;
    self.formaDeRetiro          = new FormaDeRetiro("","",0).transformar(json.formaDeRetiro);

    self.monto                  = json.monto;

    this.direccion = function () {
        return  self.formaDeRetiro.direccion
    };

    this.pizza  =function () {

        var listaDeNombres = self.platosEnConstruccion.map(function (t) { return t.nombreDePizza()});

        if ( self.platosEnConstruccion.lenght > 1  ) {
            var ultimoElemento = listaDeNombres.pop();

            return listaDeNombres.join(", ") + " y " + ultimoElemento
        }else{
            return listaDeNombres.toString()
        }

    }
    /*
        this.tranformPLatoDTO=function (aPLato){
            return new PlatoDTO(aPLato);
        }
    */

}
