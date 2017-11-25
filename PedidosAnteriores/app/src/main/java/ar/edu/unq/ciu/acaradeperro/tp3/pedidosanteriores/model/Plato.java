package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;


public class Plato {

    Pizza 			pizza;
    Tamanio 		tamanio;
    Distribucion 	ingredientesExtras;

    public Plato(Pizza unaPizza, Tamanio unTamanio, Distribucion unaDistribucion) {
        this.pizza 				= unaPizza;
        this.tamanio		    = unTamanio;
        this.ingredientesExtras	= unaDistribucion;
    }
}
