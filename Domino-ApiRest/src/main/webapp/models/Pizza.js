
function PizzaDTO(json) {

    this.nombre         = json.nombre;
    this.precioBase     = json.precio;
    this.distribucion   = new DistribucionEnPizza(json.ingredientes);

}



function Pizza(nombre,precio) {

    this.nombre         = nombre;
    this.precioBase     = precio;
    this.distribucion    = new DistribucionEnPizza([]);

}