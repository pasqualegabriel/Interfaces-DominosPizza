
function Pizza(json) {

    this.nombre         = json.nombre;
    this.precioBase     = json.precio;
    this.distribucion   = new DistribucionEnPizza(json.ingredientes);

}
