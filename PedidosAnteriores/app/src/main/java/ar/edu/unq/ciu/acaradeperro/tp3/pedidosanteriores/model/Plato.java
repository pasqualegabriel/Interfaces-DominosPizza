package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;


import java.util.List;

public class Plato {
    Pizza 			pizza;
    Tamanio 		tamanio;
    Distribucion 	ingredientesExtras;

    public Plato(Pizza unaPizza, Tamanio unTamanio, Distribucion unaDistribucion) {
        this.pizza 				= unaPizza;
        this.tamanio		    = unTamanio;
        this.ingredientesExtras	= unaDistribucion;
    }

    public String nombreDeLaPizza()
    {   return this.getPizza().getNombre(); }


    public String nombreDeTamanio()
    {   return this.getTamanio().getNombre(); }

    public String listaDeIngredientesExtras()
    {   return this.getIngredientesExtras().nombreDeIngredientes(); }

    private Pizza getPizza()
    {   return pizza;   }

    private Tamanio getTamanio()
    {   return tamanio; }

    private Distribucion getIngredientesExtras()
    {   return ingredientesExtras;  }
}
