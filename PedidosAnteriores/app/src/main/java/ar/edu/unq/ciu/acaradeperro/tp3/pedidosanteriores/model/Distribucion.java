package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;

import java.util.ArrayList;
import java.util.List;


public class Distribucion{

    // Estructura
    List<PairIngredienteDistribucionPizza> ingredientes;

    // Constructores
	public Distribucion() {
        ingredientes = new ArrayList<PairIngredienteDistribucionPizza>();
    }

    public void agregarIngrediente( Ingrediente unIngrediente, DistribucionEnPizza unaDistribucion)
    {
        this.ingredientes.add(new PairIngredienteDistribucionPizza(unIngrediente,unaDistribucion));
    }
}
