function Ingrediente(aName, aPrecio) {
    this.nombre     = aName;
    this.precio     = aPrecio;

}

function IngredienteDTO(json){
    this.nombre     = json.nombre;
    this.precio     = json.precio;

}