// Cambio
// El mismo problema que tenia userDTO. Toda la logica de modelo en el DTO


function PizzaDeAPI(json) {
    return new Pizza(json.nombre, json.precio, json.ingredientes)
}

function PizzaDTO(unaPizza) {
    this.nombre         = unaPizza.nombre;
    this.precioBase     = unaPizza.precioBase;
    this.distribucion   = unaPizza.distribucion
}

function Pizza(nombre, precio, ingredientes) {
    var self = this;

    self.nombre         = nombre;
    self.precioBase     = precio;
    self.distribucion   = new DistribucionEnPizza(ingredientes);

    this.listaDeNombresIngredientes = function(){
        if(angular.equals(self.nombre.toLocaleLowerCase(),"customizada"))
        {return "Los ingredientes que más te gustan!"}

        var listaDeNombres = self.distribucion.listarNombreIngrediente();
        if ( self.distribucion.tamanio() > 1  ) {
            var ultimoElemento = listaDeNombres.pop();

            return listaDeNombres.join(", ") + " y " + ultimoElemento
        }else{
            return listaDeNombres.toString()
        }
    };

    this.getIngredientes= function(){
        return self.distribucion.ingredientes
    }

}
