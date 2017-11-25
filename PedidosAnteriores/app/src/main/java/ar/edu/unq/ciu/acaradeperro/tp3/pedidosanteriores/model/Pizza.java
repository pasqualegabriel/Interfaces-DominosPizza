package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;

public class Pizza{

    // Atributos
    String 			nombre;
    Double 			precioBase;
    Distribucion    distribucion;

    // Constructor
	public Pizza(String unNombre, Double unPrecio, Distribucion unaDistribucion)
    {
        this.nombre 		= unNombre;
        this.precioBase 	= unPrecio;
        this.distribucion 	= unaDistribucion;
    }
}
