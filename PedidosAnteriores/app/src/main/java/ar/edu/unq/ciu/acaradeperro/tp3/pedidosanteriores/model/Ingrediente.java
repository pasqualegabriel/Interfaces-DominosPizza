package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;

public class Ingrediente
{
    String nombre;
    Double precio;

    public String nombre()
    {   return this.getNombre();    }

    private String getNombre()
    {   return nombre;  }
}
