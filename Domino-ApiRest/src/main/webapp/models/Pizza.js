
function PizzaDTO(json) {

    var self = this;
    self.nombre         = json.nombre;
    self.precioBase     = json.precio;
    self.distribucion   = new DistribucionEnPizza(json.ingredientes);

    this.listaDeNombresIngredientes = function(){
        if(angular.equals(self.nombre.toLocaleLowerCase(),"customizada"))
        {return "Con los ingredientes que más te guste."}

        var listaDeNombres = self.distribucion.listarNombreIngrediente();
        if ( self.distribucion.tamanio() > 1  ) {
            var ultimoElemento = listaDeNombres.pop();

            return listaDeNombres.join(", ") + " y " + ultimoElemento
        }else{
            return listaDeNombres.toString()
        }
    }
}



/*
function Pizza(nombre,precio) {

    this.nombre         = nombre;
    this.precioBase     = precio;
    this.distribucion    = new DistribucionEnPizza([]);


}*/
