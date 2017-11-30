package ar.edu.unq.ciu.acaradeperro.tp3.pedidosdelivery.model;

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

    public String nombreDeIngredientes()
    {
        if (! this.getIngredientes().isEmpty() && this.getIngredientes().size() > 1)
        {
            List<PairIngredienteDistribucionPizza> pares = this.getIngredientes().subList(0, this.getIngredientes().size() - 1);
            PairIngredienteDistribucionPizza ultimoPar = this.getIngredientes().get(this.getIngredientes().size() - 1);
            List<String> nombres = new ArrayList<String>();

            for (PairIngredienteDistribucionPizza par : pares) {
                nombres.add(par.nombreIngrediente());
            }
            return android.text.TextUtils.join(",", nombres).concat(" y ").concat(ultimoPar.nombreIngrediente());
        }
        else if (this.getIngredientes().size() == 1)
            { return this.getIngredientes().get(0).nombreIngrediente(); }
            else
            { return "No se eligieron Ingredientes Extras"; }

    }

    private List<PairIngredienteDistribucionPizza> getIngredientes()
    {   return ingredientes;    }
}
