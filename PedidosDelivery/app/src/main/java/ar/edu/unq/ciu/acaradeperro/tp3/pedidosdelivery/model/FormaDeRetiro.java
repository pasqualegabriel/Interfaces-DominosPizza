package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model;


public class FormaDeRetiro
{
    String tipo;
    String direccion;

    public FormaDeRetiro()
    {
        this.tipo = "";
        this.direccion = "";
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDireccion() {
        if ( this.direccion == null)
        {   return "Retira por Local"; }
        else
        { return direccion; }
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
}
