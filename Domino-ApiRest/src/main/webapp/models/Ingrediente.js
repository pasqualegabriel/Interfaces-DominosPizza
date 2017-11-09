
// Cambio
// El mismo problema que tenia userDTO. Toda la logica de modelo en el DTO


function IngredienteDTO(json){
   return new Ingrediente(json.nombre, json.precio);
}

function Ingrediente(aName, aPrecio) {

    var self = this;

    this.nombre     = aName;
    this.precio     = aPrecio;

    this.estaEnLista = function(unaLista){
        return unaLista.some(function(pairDeIngEnPizza){ return pairDeIngEnPizza.esElIngrediente(self)})
    };


}

