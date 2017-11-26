package ar.edu.unq.ciu.acaradeperro.tp3.pedidosanteriores.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;


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
        /*
        List<PairIngredienteDistribucionPizza> listaDeNombres = this.getIngredientes();
        String ultimoNombre = listaDeNombres.get(listaDeNombres.size()-1).nombreIngrediente();
        listaDeNombres.remove(listaDeNombres.size()-1);
        String resultado = "";

        for(int i=0; i < listaDeNombres.size()-1; i++)
        {
            resultado.concat(listaDeNombres.get(i).nombreIngrediente()).concat(", ");
        }
        resultado   .concat(listaDeNombres.get(listaDeNombres.size()).nombreIngrediente())
                .concat(" y ")
                .concat(ultimoNombre);
        return resultado;*/

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
