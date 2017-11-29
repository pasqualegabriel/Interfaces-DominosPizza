package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model;

public class Ingrediente
{
    String nombre;
    Double precio;

    public String nombre()
    {   return this.getNombre();    }

    private String getNombre()
    {   return nombre;  }
}
